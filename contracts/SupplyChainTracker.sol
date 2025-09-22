//

contract Project {
    // Product structure to store product information
    struct Product {
        uint256 id;
        string name;
        string description;
        address manufacturer;
        uint256 timestamp;
        string currentLocation;
        address currentOwner;
        bool isActive;
    }

    // Supply chain step structure
    struct SupplyChainStep {
        address stakeholder;
        string location;
        string action;
        uint256 timestamp;
        string remarks;
    }

    // State variables
    mapping(uint256 => Product) public products;
    mapping(uint256 => SupplyChainStep[]) public supplyChainHistory;
    mapping(address => bool) public authorizedStakeholders;
    
    uint256 public productCounter;
    address public owner;

    // Events
    event ProductCreated(uint256 indexed productId, string name, address manufacturer);
    event ProductTransferred(uint256 indexed productId, address from, address to, string newLocation);
    event SupplyChainStepAdded(uint256 indexed productId, address stakeholder, string action);
    event StakeholderAuthorized(address stakeholder);
    event StakeholderRevoked(address stakeholder);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier onlyAuthorized() {
        require(authorizedStakeholders[msg.sender] || msg.sender == owner, "Not authorized");
        _;
    }

    modifier productExists(uint256 _productId) {
        require(products[_productId].id != 0, "Product does not exist");
        _;
    }

    modifier productActive(uint256 _productId) {
        require(products[_productId].isActive, "Product is not active");
        _;
    }

    constructor() {
        owner = msg.sender;
        authorizedStakeholders[msg.sender] = true;
        productCounter = 0;
    }

    // Core Function 1: Create a new product in the supply chain
    function createProduct(
        string memory _name,
        string memory _description,
        string memory _initialLocation
    ) external onlyAuthorized returns (uint256) {
        productCounter++;
        
        Product memory newProduct = Product({
            id: productCounter,
            name: _name,
            description: _description,
            manufacturer: msg.sender,
            timestamp: block.timestamp,
            currentLocation: _initialLocation,
            currentOwner: msg.sender,
            isActive: true
        });

        products[productCounter] = newProduct;

        // Add initial supply chain step
        SupplyChainStep memory initialStep = SupplyChainStep({
            stakeholder: msg.sender,
            location: _initialLocation,
            action: "MANUFACTURED",
            timestamp: block.timestamp,
            remarks: "Product created and manufactured"
        });

        supplyChainHistory[productCounter].push(initialStep);

        emit ProductCreated(productCounter, _name, msg.sender);
        emit SupplyChainStepAdded(productCounter, msg.sender, "MANUFACTURED");

        return productCounter;
    }

    // Core Function 2: Transfer product ownership and update location
    function transferProduct(
        uint256 _productId,
        address _newOwner,
        string memory _newLocation,
        string memory _action,
        string memory _remarks
    ) external 
        onlyAuthorized 
        productExists(_productId) 
        productActive(_productId) 
    {
        require(_newOwner != address(0), "Invalid new owner address");
        require(authorizedStakeholders[_newOwner], "New owner must be authorized");
        
        Product storage product = products[_productId];
        address previousOwner = product.currentOwner;
        
        // Update product information
        product.currentOwner = _newOwner;
        product.currentLocation = _newLocation;

        // Add supply chain step
        SupplyChainStep memory newStep = SupplyChainStep({
            stakeholder: msg.sender,
            location: _newLocation,
            action: _action,
            timestamp: block.timestamp,
            remarks: _remarks
        });

        supplyChainHistory[_productId].push(newStep);

        emit ProductTransferred(_productId, previousOwner, _newOwner, _newLocation);
        emit SupplyChainStepAdded(_productId, msg.sender, _action);
    }

    // Core Function 3: Track complete supply chain history of a product
    function trackProduct(uint256 _productId) 
        external 
        view 
        productExists(_productId) 
        returns (
            Product memory product,
            SupplyChainStep[] memory history
        ) 
    {
        return (products[_productId], supplyChainHistory[_productId]);
    }

    // Additional utility functions
    function authorizeStakeholder(address _stakeholder) external onlyOwner {
        require(_stakeholder != address(0), "Invalid stakeholder address");
        authorizedStakeholders[_stakeholder] = true;
        emit StakeholderAuthorized(_stakeholder);
    }

    function revokeStakeholder(address _stakeholder) external onlyOwner {
        require(_stakeholder != owner, "Cannot revoke owner");
        authorizedStakeholders[_stakeholder] = false;
        emit StakeholderRevoked(_stakeholder);
    }

    function deactivateProduct(uint256 _productId) 
        external 
        onlyAuthorized 
        productExists(_productId) 
    {
        products[_productId].isActive = false;
        
        SupplyChainStep memory deactivationStep = SupplyChainStep({
            stakeholder: msg.sender,
            location: products[_productId].currentLocation,
            action: "DEACTIVATED",
            timestamp: block.timestamp,
            remarks: "Product deactivated"
        });

        supplyChainHistory[_productId].push(deactivationStep);
        emit SupplyChainStepAdded(_productId, msg.sender, "DEACTIVATED");
    }

    function getSupplyChainLength(uint256 _productId) 
        external 
        view 
        productExists(_productId) 
        returns (uint256) 
    {
        return supplyChainHistory[_productId].length;
    }

    function isStakeholderAuthorized(address _stakeholder) external view returns (bool) {
        return authorizedStakeholders[_stakeholder];
    }
}


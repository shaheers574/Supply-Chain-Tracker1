Supply Chain Tracker
Project Description
Supply Chain Tracker is a blockchain-based solution that provides complete transparency and traceability for products throughout their entire supply chain journey. Built on Solidity and deployed on Core Testnet 2, this smart contract system enables manufacturers, distributors, retailers, and consumers to track products from origin to final destination with immutable records.
The system creates a digital twin of physical products on the blockchain, recording every step of the supply chain process including manufacturing, transportation, warehousing, and retail distribution. Each interaction is timestamped and cryptographically secured, ensuring data integrity and preventing tampering.
Project Vision
Our vision is to revolutionize supply chain management by creating a decentralized, transparent, and trustworthy system that:

Eliminates Counterfeit Products: Provides authentic product verification through blockchain immutability
Enhances Consumer Trust: Gives consumers complete visibility into product origins and journey
Streamlines Compliance: Automates regulatory compliance and audit trails
Reduces Operational Costs: Eliminates intermediaries and reduces paperwork through automation
Promotes Sustainability: Enables tracking of sustainable and ethical sourcing practices

Key Features
🏭 Product Creation & Registration

Manufacturers can create new products with detailed information
Each product receives a unique blockchain ID
Initial supply chain step is automatically recorded
Supports comprehensive product metadata

📦 Ownership Transfer System

Secure transfer of product ownership between stakeholders
Real-time location updates throughout the supply chain
Customizable action descriptions (SHIPPED, RECEIVED, STORED, etc.)
Automated event logging and notifications

🔍 Complete Product Tracking

Full supply chain history retrieval for any product
Chronological tracking of all stakeholder interactions
Location and timestamp verification
Detailed remarks and action descriptions

🔐 Access Control & Security

Role-based access control for stakeholders
Owner-only administrative functions
Authorized stakeholder management
Product deactivation capabilities

📊 Transparency & Auditability

Immutable transaction records
Public verification of product authenticity
Comprehensive audit trails
Real-time supply chain visibility

Technical Architecture
Smart Contract Functions
Core Functions:

createProduct() - Creates new products in the supply chain
transferProduct() - Transfers ownership and updates location
trackProduct() - Retrieves complete supply chain history

Utility Functions:

authorizeStakeholder() - Grants stakeholder permissions
revokeStakeholder() - Revokes stakeholder access
deactivateProduct() - Deactivates products
getSupplyChainLength() - Returns history length
isStakeholderAuthorized() - Checks authorization status

Data Structures
soliditystruct Product {
    uint256 id;
    string name;
    string description;
    address manufacturer;
    uint256 timestamp;
    string currentLocation;
    address currentOwner;
    bool isActive;
}

struct SupplyChainStep {
    address stakeholder;
    string location;
    string action;
    uint256 timestamp;
    string remarks;
}
Installation & Setup
Prerequisites

Node.js (v16 or higher)
npm or yarn
Git

Installation Steps

Clone the repository
bashgit clone <repository-url>
cd supply-chain-tracker

Install dependencies
bashnpm install

Environment Setup

Copy .env.example to .env
Add your private key and API keys

bashcp .env.example .env

Compile contracts
bashnpm run compile

Deploy to Core Testnet 2
bashnpm run deploy


Environment Variables
Create a .env file with:
PRIVATE_KEY=your_private_key_here
CORE_TESTNET2_RPC_URL=https://rpc.test2.btcs.network
CORE_SCAN_API_KEY=your_core_scan_api_key_here
Usage Examples
Creating a Product
javascriptconst tx = await contract.createProduct(
    "Organic Coffee Beans",
    "Premium single-origin coffee from Colombian highlands",
    "Bogotá, Colombia"
);
Transferring Product
javascriptconst tx = await contract.transferProduct(
    productId,
    newOwnerAddress,
    "Miami Port, USA",
    "SHIPPED",
    "Shipped via cargo container #ABC123"
);
Tracking Product History
javascriptconst [product, history] = await contract.trackProduct(productId);
console.log("Product:", product);
console.log("Supply Chain History:", history);
Network Configuration
Core Testnet 2 Details:

RPC URL: https://rpc.test2.btcs.network
Chain ID: 1115
Explorer: https://scan.test2.btcs.network
Faucet: [Available on Core documentation]

Testing
Run the test suite:
bashnpm test
Security Considerations

All functions use appropriate access modifiers
Input validation prevents invalid operations
Event logging ensures transparency
Reentrancy protection implemented
Gas optimization for cost efficiency

Future Scope
Phase 1: Enhanced Features

IoT Integration: Connect IoT sensors for real-time temperature, humidity, and location tracking
QR Code Generation: Generate unique QR codes for each product for easy scanning
Mobile App: Develop mobile applications for stakeholders and consumers
Batch Processing: Support for bulk product operations

Phase 2: Advanced Analytics

Supply Chain Analytics: Dashboard with insights and performance metrics
Predictive Analytics: AI-powered demand forecasting and route optimization
Sustainability Metrics: Carbon footprint tracking and environmental impact analysis
Compliance Automation: Automated regulatory reporting and alerts

Phase 3: Ecosystem Expansion

Multi-Chain Support: Deploy on multiple blockchain networks
Oracle Integration: Connect with external data sources for price feeds and weather data
NFT Integration: Create NFTs for premium products with unique digital certificates
Marketplace Integration: Direct integration with e-commerce platforms

Phase 4: Enterprise Features

Enterprise API: RESTful API for easy integration with existing systems
White-label Solutions: Customizable solutions for different industries
Advanced Permissions: Role-based access control with custom permission levels
Audit Trail Export: Export capabilities for regulatory compliance

Phase 5: Interoperability

Cross-Chain Bridges: Enable product tracking across different blockchain networks
Industry Standards: Compliance with GS1, EPCIS, and other supply chain standards
Partner Ecosystem: Integration with logistics providers, certification bodies, and retailers
Global Expansion: Support for international regulations and multi-language interfaces

Contributing

Fork the repository
Create a feature branch
Commit your changes
Push to the branch
Create a Pull Request

License
This project is licensed under the MIT License - see the LICENSE file for details.
Support
For questions and support:

Create an issue in the GitHub repository
Contact the development team
Check the documentation wiki


Built with ❤️ for a more transparent supply chain 

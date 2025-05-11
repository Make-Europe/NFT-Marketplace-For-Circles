# ethDam 2025 Hackathon Entry - Rings NFT Marketplace

A decentralized NFT marketplace built for the ethDam 2025 hackathon, allowing users to create, buy, and sell Rings NFTs on the Gnosis Chain.

## Overview

This project combines the power of Circles UBI (Universal Basic Income) with NFT technology to create a unique marketplace where users can create, buy, and sell NFTs using CRC (Circles) tokens. The platform is built on the Gnosis Chain, providing fast and cost-effective transactions.

## Features

### NFT Creation
- Mint multiple NFTs in a single transaction
- Set custom event IDs for NFT categorization
- Upload metadata to IPFS
- Set prices 

### Marketplace
- Browse all available NFTs
- View detailed NFT information:
  - Token ID
  - Event ID
  - Current price
  - Owner information
- Purchase NFTs directly through the interface

### NFT Management
- View your NFT collection
- Resell NFTs with custom pricing
- Track NFT ownership history

## Technical Stack

- **Smart Contract**: Solidity 0.8.x
- **Frontend**: React.js with Tailwind CSS
- **Blockchain**: Gnosis Chain
- **Token**: RING (ERC-20)

## Prerequisites

- Node.js v18 or higher
- MetaMask wallet
- Gnosis Chain network configured in MetaMask
- RING tokens for transactions

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone [repository-url]
   cd ethdam
   ```

2. Install dependencies:
   ```bash
   # Install contract dependencies
   npm install

   # Install frontend dependencies
   cd client
   npm install
   ```

3. Configure MetaMask:
   - Add Gnosis Chain to MetaMask
   - Ensure you have RING tokens for transactions

4. Start the development server:
   ```bash
   cd client
   npm start
   ```

## Contract Interaction

The smart contract can be interacted with through:
- The React frontend interface
- Direct contract calls using scripts in the `scripts/` directory
- Web3 libraries

## Circles Trust Information

- **Avatar Type**: RegisterOrganization
- **Address**: 0xa4ecc0db5aa66881256d7000801da15a1fefe4f5
- **Chain**: RINGS

## Project Structure

```
client/
├── src/
│   ├── components/
│   │   └── RingsNFTComponent.tsx
│   ├── config/
│   │   └── circles.ts
│   ├── contracts/
│   │   └── RingsNFT.ts
│   ├── logo.svg
│   ├── App.tsx
│   └── index.tsx
├── package.json
└── tsconfig.json
```

## Development

- Frontend development: `cd client && npm start`
- Contract compilation: `npx hardhat compile`
- Contract deployment: `npx hardhat run scripts/deploy.js --network gnosis`

## License

MIT License

## Creator

[make-europe.com](https://make-europe.com)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Overview

This project combines the power of Circles UBI (Universal Basic Income) with NFT technology to create a unique marketplace where users can create, buy, and sell NFTs using CRC (Circles) tokens. The platform is built on the Gnosis Chain, providing fast and cost-effective transactions.

## Features

- **NFT Creation**: Create unique NFTs with custom names, descriptions, and images
- **Circles Integration**: All transactions are conducted using CRC tokens
- **Marketplace**: Buy and sell NFTs directly on the platform
- **User-Friendly Interface**: Modern UI with Circles branding
- **Web3 Integration**: Seamless connection with MetaMask and other Web3 wallets

## Technical Stack

- **Smart Contracts**: Solidity (ERC721)
- **Frontend**: React.js with TypeScript
- **Web3**: Web3.js
- **Styling**: Tailwind CSS
- **Blockchain**: Gnosis Chain
- **Payment**: Circles (CRC) tokens
- **Development**: TypeScript, Node.js

## Prerequisites

- Node.js >= 18 (recommended)
- MetaMask or other Web3 wallet
- Gnosis Chain network configured in your wallet
- xDAI tokens for gas fees
- Circles (CRC) tokens for NFT transactions

## Setup Instructions - Branch Master!

1. Clone the repository:
   ```bash
   git clone <https://github.com/Make-Europe/NFT-Marketplace-For-Circles/tree/master>
   cd ethdam
   ```

2. Install dependencies:
   ```bash
   cd client
   npm install
   ```

3. Configure MetaMask:
   - Add Gnosis Chain to MetaMask
   - Network Name: Gnosis Chain
   - RPC URL: https://rpc.gnosischain.com
   - Chain ID: 100
   - Currency Symbol: xDAI
   - Block Explorer: https://gnosisscan.io

4. Get Circles (CRC) tokens:
   - Visit [Circles UBI](https://joincircles.net)
   - Create an account and receive your UBI
   - Transfer some CRC to your wallet for NFT transactions

5. Start the development server:
   ```bash
   npm start
   ```

## Project Structure

```
client/
├── public/
│   └── circles-logo.svg
├── src/
│   ├── components/
│   │   └── RingsNFTComponent.tsx
│   ├── config/
│   │   └── circles.ts
│   ├── contracts/
│   │   └── RingsNFT.ts
│   ├── App.tsx
│   └── index.tsx
├── package.json
└── tsconfig.json
```

## Development

### TypeScript Configuration

The project uses TypeScript for better type safety and developer experience. The configuration is in `tsconfig.json` and includes:

- React JSX support
- Modern JavaScript features
- Strict type checking
- Module resolution for Node.js

### Circles SDK Integration

The project uses the Circles SDK for handling CRC transactions. Configuration is in `src/config/circles.ts` and includes:

- RPC endpoints
- Contract addresses
- Service URLs

### Available Scripts

- `npm start`: Runs the app in development mode
- `npm test`: Launches the test runner
- `npm run build`: Builds the app for production
- `npm run eject`: Ejects from Create React App

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Creator

Built with ❤️ by https://make-europe.com for ETHDam 2025

## Acknowledgments

- [Circles UBI](https://joincircles.net) for the payment infrastructure
- [Gnosis Chain](https://gnosischain.com) for the blockchain platform
- [Create React App](https://create-react-app.dev) for the development environment
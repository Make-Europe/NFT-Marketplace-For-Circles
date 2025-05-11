require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    gnosis: {
      url: "https://rpc.gnosischain.com",
      chainId: 100,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    },
    chiado: {
      url: "https://rpc.chiadochain.net",
      chainId: 10200,
      accounts: process.env.PRIVATE_KEY ? [process.env.PRIVATE_KEY] : [],
    }
  },
  etherscan: {
    apiKey: {
      gnosis: process.env.GNOSISSCAN_API_KEY,
      chiado: process.env.GNOSISSCAN_API_KEY
    },
    customChains: [
      {
        network: "gnosis",
        chainId: 100,
        urls: {
          apiURL: "https://api.gnosisscan.io/api",
          browserURL: "https://gnosisscan.io"
        }
      },
      {
        network: "chiado",
        chainId: 10200,
        urls: {
          apiURL: "https://blockscout.com/gnosis/chiado/api",
          browserURL: "https://blockscout.com/gnosis/chiado"
        }
      }
    ]
  }
};

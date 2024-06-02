
require("@nomiclabs/hardhat-waffle");
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();
require("solidity-coverage");
require("hardhat-deploy");
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const COINMARKETCAP_API_KEY = process.env.COINMARKETCAP_API_KEY;
const SEPOLIA_RPC_URL =
  process.env.SEPOLIA_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY ;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;
const POLYGON1_API_KEY=process.env.POLYGON1_API_KEY;
const POLYGON1_RPC_URL=process.env.POLYGON1_RPC_URL;
const POLYGON2_API_KEY=process.env.POLYGON2_API_KEY;
const POLYGON2_RPC_URL=process.env.POLYGON2_RPC_URL;
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
      // gasPrice: 130000000000,
    },
    localhost: {
      chainId: 31337,
    },
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
      blockConfirmations: 6,
    },
    polygon1:{
      url:POLYGON1_RPC_URL,
      accounts:[PRIVATE_KEY],
      chainId:  2442 ,
      blockConfirmations:6,
    },
    polygon2:{
      url:POLYGON2_RPC_URL,
      accounts:[PRIVATE_KEY],
      chainId:  80002,
      blockConfirmations:6,
    }
  },
  solidity: {
    compilers: [
      {
        version: "0.8.20",
      },
      {
        version: "0.6.6",
      },
      {
        version: "0.8.25",
      },
    ],
  },
  etherscan: {
    apiKey: POLYGON2_API_KEY,
    customChains: [{
   network:'Polygon Amoy Testnet',
   chainId:80002,
   urls: {
    apiURL: "https://api-amoy.polygonscan.com/api",
    browserURL: "https://amoy.polygonscan.com/"
  }
  }],
  },

  gasReporter: {
    enabled: true,
    currency: "USD",
    outputFile: "gas-report.txt",
    noColors: true,
    coinmarketcap: COINMARKETCAP_API_KEY,
  },
  namedAccounts: {
    deployer: {
      default: 0, // here this will by default take the first account as deployer
      1: 0, // similarly on mainnet it will take the first account as deployer. Note though that depending on how hardhat network are configured, the account 0 on one network can be different than on another
    },
  },
  mocha: {
    timeout: 200000, // 200 seconds max for running tests
  },
};
//1. Initialize `truffle-hdwallet-provider`
const HDWalletProvider = require("truffle-hdwallet-provider");
// Initialize LoomTruffleProvider
//const LoomTruffleProvider = require('loom-truffle-provider');
// Set your own mnemonic here
const mnemonic = "YOUR_MNEMONIC";

// Module exports to make this configuration available to Truffle itself
module.exports = {
  // Object with configuration for each network
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    // Configuration for mainnet
    mainnet: {
      provider: function () {
        // Setting the provider with the Infura Mainnet address and Token
        return new HDWalletProvider(mnemonic, "https://mainnet.infura.io/v3/YOUR_TOKEN")
      },
      network_id: "1"
    },
    // Configuration for rinkeby network
    rinkeby: {
      // Special function to setup the provider
      provider: function () {
        // Setting the provider with the Infura Rinkeby address and Token
        return new HDWalletProvider(mnemonic, "https://rinkeby.infura.io/v3/YOUR_TOKEN")
      },
      network_id: 4 //Fill in the `network_id` for the Rinkeby network.

    }
    loom_testnet: {
      provider: function() {
        const privateKey = 'YOUR_PRIVATE_KEY'
        const chainId = 'extdev-plasma-us1';
        const writeUrl = 'http://extdev-plasma-us1.dappchains.com:80/rpc';
        const readUrl = 'http://extdev-plasma-us1.dappchains.com:80/query';
        return new LoomTruffleProvider(chainId, writeUrl, readUrl, privateKey);
      },
      network_id: '9545242630824'
    }
  }
};

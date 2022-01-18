var CryptoAvatars = artifacts.require("CryptoAvatars");
var CryptoPieces = artifacts.require("CryptoPieces");

module.exports = function (deployer) {
  deployer.deploy(CryptoAvatars);
  deployer.deploy(CryptoPieces);
};
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarfactory.sol";

//Examples of mapping different qualities of the avatar/race that is going to be the couple to our avatar from: NFT collections, other Games, etc.
//Example: Qualities from crypto kitties
abstract contract KittyInterface {

    function getKitty(uint256 _id) external virtual view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}
//modify
abstract contract CypherPunkInterface {

    function getCypherPunk(uint256 _id) external virtual view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}
//modify
abstract contract BoredApeInterface {

    function getBoredApe(uint256 _id) external virtual view returns (
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract AvatarMigration is AvatarFactory {

     KittyInterface kittyContract;
     CypherPunkInterface cypherPunkContract;
     BoredApeInterface boredApeContract;

    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    function setCypherPunkContractAddress(address _address) external onlyOwner {
        cypherPunkContract = CypherPunkInterface(_address);
    }

    function setBoredApeContractAddress(address _address) external onlyOwner {
        boredApeContract = BoredApeInterface(_address);
    }

    function migrateKitty(uint _kittyId) public payable {
        require(msg.value == avatarCreationFee);
        bytes32 _race = keccak256(abi.encodePacked("kitty"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = kittyContract.getKitty(_kittyId);
        _createAvatar(_race, _sex, _dna);
    }

    function migrateBoredApe(uint _boredApeId) public payable {
        require(msg.value == avatarCreationFee);
        bytes32 _race = keccak256(abi.encodePacked("boredApe"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = boredApeContract.getBoredApe(_boredApeId);
        _createAvatar(_race, _sex, _dna);
    }


    function migrateCypherPunk(uint _cypherPunkId) public payable {
        require(msg.value == avatarCreationFee);
        bytes32 _race = keccak256(abi.encodePacked("cypherPunk"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = cypherPunkContract.getCypherPunk(_cypherPunkId);
        _createAvatar(_race, _sex, _dna);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecefactory.sol";

//Examples of mapping different qualities of the piece/class that is going to be the couple to our piece from: NFT collections, other Games, etc.
//Example: Qualities from crypto kitties
abstract contract KittyInterface2 {

    function getKitty2(uint256 _id) external virtual view returns (
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
abstract contract CypherPunkInterface2 {

    function getCypherPunk2(uint256 _id) external virtual view returns (
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
abstract contract BoredApeInterface2 {

    function getBoredApe2(uint256 _id) external virtual view returns (
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

contract PieceMigration is PieceFactory {

     KittyInterface2 kittyContract2;
     CypherPunkInterface2 cypherPunkContract2;
     BoredApeInterface2 boredApeContract2;

    function setKittyContractAddress2(address _address) external onlyOwner {
        kittyContract2 = KittyInterface2(_address);
    }

    function setCypherPunkContractAddress2(address _address) external onlyOwner {
        cypherPunkContract2 = CypherPunkInterface2(_address);
    }

    function setBoredApeContractAddress2(address _address) external onlyOwner {
        boredApeContract2 = BoredApeInterface2(_address);
    }

    function migrateKitty2(uint _kittyId) public payable {
        require(msg.value == pieceCreationFee);
        bytes32 _class = keccak256(abi.encodePacked("kitty"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = kittyContract2.getKitty2(_kittyId);
        _createPiece(_class, _sex, _dna);
    }

    function migrateBoredApe2(uint _boredApeId) public payable {
        require(msg.value == pieceCreationFee);
        bytes32 _class = keccak256(abi.encodePacked("boredApe"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = boredApeContract2.getBoredApe2(_boredApeId);
        _createPiece(_class, _sex, _dna);
    }


    function migrateCypherPunk2(uint _cypherPunkId) public payable {
        require(msg.value == pieceCreationFee);
        bytes32 _class = keccak256(abi.encodePacked("cypherPunk"));
        string memory _sex = _randSex();
        uint _dna;
        (,,,,,,,,,_dna) = cypherPunkContract2.getCypherPunk2(_cypherPunkId);
        _createPiece(_class, _sex, _dna);
    }
}
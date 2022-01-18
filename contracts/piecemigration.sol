// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecefactory.sol";

//Examples of mapping different qualities of the piece/class that is going to be the couple to our piece from: NFT collections, other Games, etc.
//Example: 10kTF

contract ShoesInterface {

    function getShoes(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract SocksInterface {

    function getSocks(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract PantsInterface {

    function getPants(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract UnderwearInterface {

    function getUnderwear(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract ShirtInterface {

    function getShirt(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract HoodieInterface {

    function getHoodie(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract SnapbackInterface {

    function getSnapback(uint256 _id) external view returns (
        bool isReady,
        uint256 cooldownIndex,
        uint256 backGround,
        uint256 collection,
        uint256 item,
        uint256 parentName,
        uint256 year,
        uint256 property
    );
}

contract PieceMigration is PieceFactory {

     uint createPieceFee = 1 ether;

     ShoesInterface ShoesContract;
     SocksInterface SocksContract;
     PantsInterface PantsContract;
     UnderwearInterface UnderwearContract;
     ShirtInterface ShirtContract;
     HoodieInterface HoodieContract;
     SnapbackInterface SnapbackContract;    

    function setShoesContractAddress(address _address) external onlyOwner {
        ShoesContract = ShoesInterface(_address);
    }
    
    function setSocksContractAddress(address _address) external onlyOwner {
        SocksContract = SocksInterface(_address);
    }
    
    function setPantsContractAddress(address _address) external onlyOwner {
        PantsContract = PantsInterface(_address);
    }
    
    function setUnderwearContractAddress(address _address) external onlyOwner {
        UnderwearContract = UnderwearInterface(_address);
    }
    
    function setShirtContractAddress(address _address) external onlyOwner {
        ShirtContract = ShirtInterface(_address);
    }
    
    function setHoodieContractAddress(address _address) external onlyOwner {
        HoodieContract = HoodieInterface(_address);
    }
    
    function setSnapbackContractAddress(address _address) external onlyOwner {
        SnapbackContract = SnapbackInterface(_address);
    }
    
    function migrateShoesItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Shoes"));
        uint _dna;
        (,,,,,,,_dna) = ShoesContract.getShoes(_itemId);
        _createPiece(_class, _dna, _curr_loc);
    }

    function migrateSocksItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Socks"));
        uint _dna;
        (,,,,,,,_dna) = SocksContract.getSocks(_itemId);
        _createPiece(_class, _dna, _curr_loc);
    }

    function migratePantsItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Pants"));
        uint _dna;
        (,,,,,,,_dna) = PantsContract.getPants(_itemId);
        _createPiece(_class, _dna, _curr_loc);
    }

    function migrateUnderwearItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Underwear"));
        uint _dna;
        (,,,,,,,_dna) = UnderwearContract.getUnderwear(_itemId);
        _createPiece(_class, _dna, _curr_loc);
    }
    
    function migrateShirtItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Shirt"));
        uint _dna;
        (,,,,,,,_dna) = ShirtContract.getShirt(_itemId);
        _createPiece(_class, _dna, _curr_loc);
    }

    function migrateSnapbackItem(uint _itemId, uint256 _curr_loc) public payable {
        require(msg.value == createPieceFee);
        bytes32 _class = keccak256(abi.encodePacked("Snapback"));
        uint _dna;
        (,,,,,,,_dna) = ShirtContract.getShirt(_itemId);
        //(,,,,,,,_dna) = _generateRandomPieceDna(abi.encodePacked(SnapbackContract.getSnapback(_itemId), " Snapback"));
        //_dna = _dna - _dna % 100;
        _createPiece(_class, _dna, _curr_loc);
    }

}
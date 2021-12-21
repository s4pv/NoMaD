// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";

contract PieceFactory is Ownable {
    event NewPiece(uint pieceId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Piece {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Piece[] public pieces;

    mapping (uint => address) public pieceToOwner;
    mapping (address => uint) ownerPieceCount;

    function _createPiece(string memory _name, uint _dna) internal {
        uint id = pieces.push(Piece(_name, _dna)) -1;
        pieceToOwner[id] = msg.sender;
        ownerPieceCount[msg.sender]++;
        emit NewPiece(id, _name, _dna);
    }

    function _generateRandomDna(string memory_str) private views returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomPiece(string memory _name) public {
        require(ownerPieceCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createPiece(_name, randDna);
    }
}
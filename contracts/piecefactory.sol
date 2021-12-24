// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";

contract PieceFactory is Ownable {

    event NewPiece(uint pieceId, string pieceName, string pieceClass, string pieceSex, uint pieceDna, uint32 pieceReadyTime, uint8 pieceAge, uint8 pieceLevel,  uint8 pieceLuck, uint8 pieceInt, uint8 pieceAgi, uint8 pieceStr, uint8 pieceSta, uint8 pieceMergeCount);

    uint pieceDnaDigits = 16;
    uint pieceDnaModulus = 10 ** pieceDnaDigits;
    uint pieceCdTime = 1 days;

    struct Piece {
        string pieceName;
        string pieceClass;
        string pieceSex;
        uint32 pieceReadyTime;
        uint pieceDna;
        uint8 pieceAge;
        uint8 pieceLevel;
        uint8 pieceLuck;
        uint8 pieceIntellect;
        uint8 pieceAgility;
        uint8 pieceStrength;
        uint8 pieceStamina;
        uint8 mergeCount;
    }

    Piece[] public pieces;

    mapping (uint => address) public pieceToOwner;
    mapping (address => uint) ownerPieceCount;

    uint pieceCreationFee = 1 ether;
    uint randNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _modulus;
    }

    function _randSex() internal returns(string) {
        uint maleProbability = 50;
        string _sex;
        if (randMod(100) <= maleProbability) {
            _sex = "male";
        } else {
            _sex = "female";
        }
        return (_sex);
    }

    function _createPiece(string memory _name, string _class, string _sex, uint _dna) internal payable {
        require(msg.value == pieceCreationFee);
        uint32 _readyTime = uint32(now + pieceCdTime);
        uint8 _age = 1;
        uint8 _lvl = 1;
        uint8 _luk = 1;
        uint8 _int = 1;
        uint8 _agi = 1;
        uint8 _str = 1;
        uint8 _sta = 1;
        uint8 _mergeCount = 0;
        uint pieceId = pieces.push(Piece(_name, _class, _sex, _dna, _readyTime, _age, _lvl, _luk, _int, _agi, _str, _sta, _mergeCount)) - 1;
        pieceToOwner[pieceId] = msg.sender;
        ownerPieceCount[msg.sender]++;
        emit NewPiece(pieceId, _name, _class, _sex, _dna, _readyTime, _age, _lvl, _luk, _int, _agi, _str, _sta, _mergeCount);
    }

    function _generateRandomPieceDna(string memory _str) private view returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % pieceDnaModulus;
    }

    function createRandomPiece(string memory _name, string _sex) public {
        require(ownerPieceCount[msg.sender] == 0);
        string _class = "traveler";
        uint randDna = _generateRandomPieceDna(_name);
        randDna = randDna - randDna % 100;
        _createPiece(_name, _class, _sex, randDna);
    }
}
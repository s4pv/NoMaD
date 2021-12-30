// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";
import "./safemath.sol";

contract PieceFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewPiece(uint pieceId, uint pieceDna, string pieceName, string pieceSex, bytes32 pieceClass, uint32 pieceReadyTime, uint16 pieceLevel,  uint16 pieceLuck, uint16 pieceInt, uint16 pieceAgi, uint16 pieceStr, uint16 pieceSta, uint16 pieceMergeCount);

    uint pieceDnaDigits = 16;
    uint pieceDnaModulus = 10 ** pieceDnaDigits;
    uint pieceCdTime = 1 days;

    struct Piece {
        uint pieceDna;
        string pieceName;
        string pieceSex;
        bytes32 pieceClass;
        uint32 pieceReadyTime;
        uint16 pieceLevel;
        uint16 pieceLuck;
        uint16 pieceIntellect;
        uint16 pieceAgility;
        uint16 pieceStrength;
        uint16 pieceStamina;
        uint16 mergeCount;
    }

    Piece[] public pieces;

    mapping (uint => address) public pieceToOwner;
    mapping (address => uint) ownerPieceCount;

    uint pieceCreationFee = 1 ether;
    uint randNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modulus;
    }

    function _randSex() internal returns(string memory) {
        uint maleProbability = 50;
        string memory _sex;
        if (randMod(100) <= maleProbability) {
            _sex = "male";
        } else {
            _sex = "female";
        }
        return (_sex);
    }

    function _createPiece(bytes32 _class, string memory _sex, uint _dna) internal {
        uint32 _readyTime = uint32(block.timestamp + pieceCdTime);
        // Note: We chose not to prevent the year 2038 problem... So don't need
        // worry about overflows on readyTime. Our app is screwed in 2038 anyway ;)
        pieces.push(Piece(_dna, "NoName", _sex, _class, _readyTime, 1, 1, 1, 1, 1, 1, 0));
        uint pieceId = pieces.length -1;
        pieceToOwner[pieceId] = msg.sender;
        ownerPieceCount[msg.sender] = ownerPieceCount[msg.sender].add(1);
        emit NewPiece(pieceId, _dna, "NoName", _sex, _class, _readyTime, 1, 1, 1, 1, 1, 1, 0);
    }

    function _generateRandomPieceDna(string memory _str) private view returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % pieceDnaModulus;
    }

    function createRandomPiece(string memory _name, string memory _sex) public payable {
        require(msg.value == pieceCreationFee);
        require(ownerPieceCount[msg.sender] == 0);
        bytes32 _class = keccak256(abi.encodePacked("traveler"));
        uint randDna = _generateRandomPieceDna(_name);
        randDna = randDna - randDna % 100;
        _createPiece(_class, _sex, randDna);
    }
}
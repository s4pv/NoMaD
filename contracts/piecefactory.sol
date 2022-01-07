// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";
import "./safemath.sol";

contract PieceFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewPiece(uint pieceId, uint pieceDna, bytes32 pieceClass, uint32 pieceReadyTime, uint16 pieceLevel,  uint16 pieceLuck, uint16 pieceInt, uint16 pieceAgi, uint16 pieceStr, uint16 pieceSta, uint16 pieceMergeCount);

    uint pieceDnaDigits = 16;
    uint pieceDnaModulus = 10 ** pieceDnaDigits;
    uint pieceCdTime = 1 days;

    struct Piece {
        uint pieceDna;
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

    uint pieceCreationFee = 0.1 ether;
    uint randPieceNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randPieceNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randPieceNonce))) % _modulus;
    }

    function _createPiece(bytes32 _class, uint _dna) internal {
        uint32 _readyTime = uint32(block.timestamp + pieceCdTime);
        // Note: We chose not to prevent the year 2038 problem... So don't need
        // worry about overflows on readyTime. Our app is screwed in 2038 anyway ;)
        pieces.push(Piece(_dna, _class, _readyTime, 1, 1, 1, 1, 1, 1, 0));
        uint pieceId = pieces.length -1;
        pieceToOwner[pieceId] = msg.sender;
        ownerPieceCount[msg.sender] = ownerPieceCount[msg.sender].add(1);
        emit NewPiece(pieceId, _dna, _class, _readyTime, 1, 1, 1, 1, 1, 1, 0);
    }

    function _generateRandomPieceDna(string memory _str) private view returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % pieceDnaModulus;
    }

  function createShoes() private {
     bytes32 _class = keccak256(abi.encodePacked("Shoes"));
     uint randDna = _generateRandomPieceDna("Blank Shoes");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createSocks() private {
     bytes32 _class = keccak256(abi.encodePacked("Socks"));
     uint randDna = _generateRandomPieceDna("Blank Socks");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }


  function createPants() private {
     bytes32 _class = keccak256(abi.encodePacked("Pants"));
     uint randDna = _generateRandomPieceDna("Blank Pants");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createUnderwear() private {
     bytes32 _class = keccak256(abi.encodePacked("Underwear"));
     uint randDna = _generateRandomPieceDna("Blank Underwear");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createShirt() private {
     bytes32 _class = keccak256(abi.encodePacked("Shirt"));
     uint randDna = _generateRandomPieceDna("Blank Shirt");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createHoodie() private {
     bytes32 _class = keccak256(abi.encodePacked("Hoodie"));
     uint randDna = _generateRandomPieceDna("Blank Hoodie");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createSnapback() private {
     bytes32 _class = keccak256(abi.encodePacked("Snapback"));
     uint randDna = _generateRandomPieceDna("Blank Snapback");
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createTravelPaint(uint256 _ini_loc, uint256 _end_loc) private {
     bytes32 _class = keccak256(abi.encodePacked("Travel Paint"));
     uint randDna = _generateRandomPieceDna(string(abi.encodePacked(_ini_loc, _end_loc)));
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createTravelItem(uint256 _ini_loc, uint256 _end_loc) private {
     bytes32 _class = keccak256(abi.encodePacked("Travel Item"));
     uint randDna = _generateRandomPieceDna(string(abi.encodePacked(_ini_loc, _end_loc)));
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

  function createTravelCoupon(uint256 _ini_loc, uint256 _end_loc) private {
     bytes32 _class = keccak256(abi.encodePacked("Travel Coupon"));
     uint randDna = _generateRandomPieceDna(string(abi.encodePacked(_ini_loc, _end_loc)));
     randDna = randDna - randDna % 100;
     _createPiece(_class, randDna);
  }

}
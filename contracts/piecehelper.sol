// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";

contract PieceHelper is PieceMerging {

  uint changePieceDnaFee = 10 ether;
  uint withdrawPieceFee = 0.01 ether;

  function withdrawPiece() external payable onlyOwner {
    require(msg.value == withdrawPieceFee);
    address _owner = owner();
    payable(_owner).transfer(address(this).balance);
  }

  function getPiecesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerPieceCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < pieces.length; i++) {
      if (pieceToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

  function createBlankShoes() external payable {
     require(msg.value == pieceCreationFee);
     createShoes();
  }

  function createBlankSocks() external payable {
     require(msg.value == pieceCreationFee);
     createSocks();
  }

  function createBlankPants() external payable {
     require(msg.value == pieceCreationFee);
     createPants();
  }

  function createBlankUnderwear() external payable {
     require(msg.value == pieceCreationFee);
     createPants();
  }

  function createBlankShirt() external payable {
     require(msg.value == pieceCreationFee);
     createShirt();
  }

  function createBlankHoodie() external payable {
     require(msg.value == pieceCreationFee);
     createHoodie();
  }

  function createBlankSnapback() external payable {
     require(msg.value == pieceCreationFee);
     createSnapback();
  }

  function createTravelGift(uint256 _ini_loc, uint256 _end_loc) external payable {
     require(msg.value == pieceCreationFee);
     uint rand = randMod(100);
     if (rand < 50) {
         createTravelPaint(_ini_loc, _end_loc);
     } else if (rand < 75) {
         createTravelItem(_ini_loc, _end_loc);
     } else {
         createTravelCoupon(_ini_loc, _end_loc);
     }
  }
}
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

  function changePieceDna(uint _pieceId, uint _newDna) external payable onlyOwnerOfPiece(_pieceId) {
    require(msg.value == changePieceDnaFee);
    pieces[_pieceId].pieceDna = _newDna;
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

  function _firstHomeSetRewards(uint256 _curr_loc) internal {
      _createUnderwear(_curr_loc);
      _createSocks(_curr_loc);
      }

  function _firstWorkPlaceSetRewards(uint256 _curr_loc) internal {
      _createShirt(_curr_loc);
      _createPants(_curr_loc);
      _createShoes(_curr_loc);
      }

  function _createTravelGift(uint256 _ini_loc, uint256 _end_loc) internal {
     uint rand = randPieceMod(100);
     if (rand < 50) {
         _createTravelPaint(_ini_loc, _end_loc);
     } else if (rand < 75) {
         _createTravelItem(_ini_loc, _end_loc);
     } else {
         _createTravelCoupon(_ini_loc, _end_loc);
     }
  }
}
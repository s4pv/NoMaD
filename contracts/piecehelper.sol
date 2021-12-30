// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";

contract PieceHelper is PieceMerging {

  modifier abovePieceLevel(uint _level, uint _pieceId) {
    require(pieces[_pieceId].pieceLevel >= _level);
    _;
  }
  function withdrawPiece() external payable onlyOwner {
    require(msg.value == withdrawPieceFee);
    address _owner = owner();
    payable(_owner).transfer(address(this).balance);
  }
  uint changePieceNameFee = 0.1 ether;
  uint changePieceDnaFee = 10 ether;
  uint withdrawPieceFee = 0.01 ether;

  function changePieceName(uint _pieceId, string calldata _newName) external payable abovePieceLevel(2, _pieceId) onlyOwnerOfPiece(_pieceId) {
    require(msg.value == changePieceNameFee);
    pieces[_pieceId].pieceName = _newName;
  }

  function changePieceDna(uint _pieceId, uint _newDna) external payable abovePieceLevel(10, _pieceId) onlyOwnerOfPiece(_pieceId) {
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

}

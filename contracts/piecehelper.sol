// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";

contract PieceHelper is PieceBreeding {

  modifier abovePieceLevel(uint _level, uint _pieceId) {
    require(pieces[_pieceId].level >= _level);
    _;
  }
  function withdrawPiece() external onlyOwnerOfPiece {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }
  uint changeNameFee = 0.1 ether;
  uint changeDnaFee = 10 ether;

  function changePieceName(uint _pieceId, string calldata _newName) external payable abovePieceLevel(2, _pieceId) onlyOwnerOfPiece(_pieceId) {
    require(msg.value == changeNameFee);
    pieces[_pieceId].name = _newName;
  }

  function changePieceDna(uint _pieceId, uint _newDna) external payable abovePieceLevel(10, _pieceId) onlyOwnerOfPiece(_pieceId) {
    require(msg.value == changeDnaFee);
    pieces[_pieceId].dna = _newDna;
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

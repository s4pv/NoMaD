// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";

contract PieceHelper is PieceMerging {

  modifier aboveLevel(uint _level, uint _pieceId) {
    require(pieces[_pieceId].level >= _level);
    _;
  }

  function changeName(uint _pieceId, string calldata _newName) external aboveLevel(2, _pieceId) {
    require(msg.sender == pieceToOwner[_pieceId]);
    pieces[_piecesId].name = _newName;
  }

  function changeDna(uint _pieceId, uint _newDna) external aboveLevel(10, _pieceId) {
    require(msg.sender == pieceToOwner[_pieceId]);
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

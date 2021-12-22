// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";

contract PieceHelper is PieceMerging {

  modifier aboveLevel(uint _level, uint _pieceId) {
    require(pieces[_pieceId].level >= _level);
    _;
  }

  function withdraw() external onlyOwner {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }

  uint changeNameFee = 0.1 ether;
  uint changeDnaFee = 10 ether;

  //modify functions to ones that have sense
  function changeName(uint _pieceId, string calldata _newName) external aboveLevel(2, _pieceId) ownerOf(_pieceId) payable {
    require(msg.value == changeNameFee);
    pieces[_piecesId].name = _newName;
  }

  function changeDna(uint _pieceId, uint _newDna) external aboveLevel(10, _pieceId) ownerOf(_pieceId) payable {
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

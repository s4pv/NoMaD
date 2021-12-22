// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecehelper.sol";
//not secure
contract pieceMerge is PieceHelper {
  uint randNonce = 0;
  uint mergeProbability = 70;
  uint maxMerge = 1;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _modulus;
  }

  function merge(uint _pieceId, uint _targetPieceId) external ownerOf(_pieceId) {
    Piece storage myPiece = pieces[_pieceId];
    Piece storage enemyPiece = pieces[_targetId];
    uint rand = randMod(100);
    if (rand <= mergeProbability && myPiece.mergeCount <= maxMerge) {
      mergeAndMultiply(_pieceId,_targetPiece.dna, "ticket"); //modify "" later to a build artifacts
    }// else if (rand > mergeProbability && myPiece.mergeCount <= maxMerge){
    //}
    myPiece.mergeCount++;
    //_triggerCooldown(myPiece);
  }
}
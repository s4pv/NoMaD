// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemigration.sol";

contract PieceMerging is PieceMigration {

     uint mergeProbability = 90;
     uint maxMerge = 7;
    modifier onlyOwnerOfPiece(uint _pieceId) {
        require(msg.sender == pieceToOwner[_pieceId]);
        _;
    }

    function _triggerCd(Piece storage _piece) internal {
        _piece.readyTime = uint32(now + pieceCdTime);
    }

    function _isReady(Piece storage _piece) internal view returns (bool) {
       return (_piece.readyTime <= now);
    }

    uint mergeFee = 1 ether; //live tokens

    function merge(uint _pieceId, uint _targetPieceId) internal onlyOwnerOfPiece(_pieceId) onlyOwnerOfPiece(_targetPieceId) payable {
        Piece storage myPiece = pieces[_pieceId];
        Piece storage targetPiece = pieces[_targetPieceId];
        require(_isReady(myPiece));
        require (_isReady(targetPiece));
        require(msg.value == mergeFee);
        uint newDna = (myPiece.pieceDna + targetPiece.pieceDna) / 2;
        uint newClass;
        if ((myPiece.pieceClass == "cypherPunk" && targetPiece.pieceClass == "traveler") || (myPiece.pieceClass == "traveler" && targetPiece.pieceClass == "cypherPunk")) {
            newClass = "cypherTraveler";
        }
        if ((myPiece.pieceClass == "kitty" && targetPiece.pieceClass == "traveler") || (myPiece.pieceClass == "traveler" && targetPiece.pieceClass == "kitty")) {
            newClass = "kittyTraveler";
        }
        if ((myPiece.pieceClass == "boredApe" && targetPiece.pieceClass == "traveler") || (myPiece.pieceClass == "traveler" && targetPiece.pieceClass == "boredApe")) {
            newClass = "boredPiece";
        }
        if ((myPiece.pieceClass == "cypherPunk" && targetPiece.pieceClass == "kitty") || (myPiece.pieceClass == "kitty" && targetPiece.pieceClass == "cypherPunk")) {
            newClass = "cypherKitty";
        }
        if ((myPiece.pieceClass == "cypherPunk" && targetPiece.pieceClass == "boredApe") || (myPiece.pieceClass == "boredApe" && targetPiece.pieceClass == "cypherPunk")) {
            newClass = "cypherApe";
        }
        if ((myPiece.pieceClass == "kitty" && targetPiece.pieceClass == "boredApe") || (myPiece.pieceClass == "boredApe" && targetPiece.pieceClass == "kitty")) {
            newClass = "kitty";
        }
        if (myPiece.pieceClass == "traveler" && targetPiece.pieceClass == "traveler") {
            newClass = "traveler";
        }
        else {
            newClass = "newClasss";
        }
        uint rand = randMod(100);
        if (rand <= mergeProbability && myPiece.mergeCount <= maxMerge) {
            _createPiece("NoName", newClass, _randSex(), newDna);
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
            myPiece.mergeCount++;
        } else if (rand <= mergeProbability && myPiece.mergeCount <= maxMerge) {
            _createPiece("NoName", newClass, _randSex(), newDna);
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
            myPiece.mergeCount++;
        }
    }
}

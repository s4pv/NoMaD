// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemigration.sol";
import "./safemath.sol";

contract PieceMerging is PieceMigration {

    using SafeMath16 for uint16;

    uint mergeProbability = 90;
    uint maxMerge = 7;
    modifier onlyOwnerOfPiece(uint _pieceId) {
        require(msg.sender == pieceToOwner[_pieceId]);
        _;
    }

    function _triggerCd(Piece storage _piece) internal {
        _piece.pieceReadyTime = uint32(block.timestamp + pieceCdTime);
    }

    function _isReady(Piece storage _piece) internal view returns (bool) {
       return (_piece.pieceReadyTime <= block.timestamp);
    }

    uint mergeFee = 1 ether; //live tokens

    function merge(uint _pieceId, uint _targetPieceId) external onlyOwnerOfPiece(_pieceId) onlyOwnerOfPiece(_targetPieceId) payable {
        Piece storage myPiece = pieces[_pieceId];
        Piece storage targetPiece = pieces[_targetPieceId];
        require(_isReady(myPiece));
        require (_isReady(targetPiece));
        require(msg.value == mergeFee);
        uint newDna = (myPiece.pieceDna + targetPiece.pieceDna) / 2;
        bytes32 newClass;
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("traveler")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("traveler"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))))) {
            newClass = keccak256(abi.encodePacked("cypherTraveler"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("kitty"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("traveler")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("traveler"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("kitty"))))) {
            newClass = keccak256(abi.encodePacked("kittyTraveler"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("traveler")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("traveler"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))))) {
            newClass = keccak256(abi.encodePacked("boredTraveler"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("kitty")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("kitty"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))))) {
            newClass = keccak256(abi.encodePacked("cypherKitty"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("boredApe")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))))) {
            newClass = keccak256(abi.encodePacked("cypherApe"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("kitty"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("boredApe")))) || ((myPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("kitty"))))) {
            newClass = keccak256(abi.encodePacked("kitty"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("traveler"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("traveler"))))) {
            newClass = keccak256(abi.encodePacked("traveler"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("kitty"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("kitty"))))) {
            newClass = keccak256(abi.encodePacked("kitty"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("boredApe"))))) {
            newClass = keccak256(abi.encodePacked("boredApe"));
        }
        if (((myPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("cypherPunk"))))) {
            newClass = keccak256(abi.encodePacked("cypherPunk"));
        }
        else {
            newClass = keccak256(abi.encodePacked("newClasses"));
        }
        uint rand = randMod(100);
        if (rand <= mergeProbability && myPiece.mergeCount <= maxMerge) {
            _createPiece(newClass, _randSex(), newDna);
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
            myPiece.mergeCount = myPiece.mergeCount.add(1);
        } else if (rand > mergeProbability && myPiece.mergeCount <= maxMerge) {
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
            myPiece.mergeCount = myPiece.mergeCount.add(1);
        }
    }
}

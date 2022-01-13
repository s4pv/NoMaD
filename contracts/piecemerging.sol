// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemigration.sol";
import "./safemath.sol";


contract PieceMerging is PieceMigration {

    using SafeMath16 for uint16;

    uint mergeProbability = 95;
    uint maxMerge = 1;
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

    uint mergeFee = 0.1 ether; //live tokens

    function merge(uint _pieceId, uint _targetPieceId, uint256 _curr_loc) public onlyOwnerOfPiece(_pieceId) onlyOwnerOfPiece(_targetPieceId) payable {
        Piece storage myPiece = pieces[_pieceId];
        Piece storage targetPiece = pieces[_targetPieceId];
        require(_isReady(myPiece));
        require (_isReady(targetPiece));
        require(msg.value == mergeFee);
        uint newDna = (myPiece.pieceDna + targetPiece.pieceDna) / 2;
        bytes32 newClass;
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Shoes"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Shoes")))))) {
            newClass = keccak256(abi.encodePacked("Painted Shoes"));
        }
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Socks"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Socks")))))) {
            newClass = keccak256(abi.encodePacked("Painted Socks"));
        }
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Pants"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Pants")))))) {
            newClass = keccak256(abi.encodePacked("Painted Pants"));
        }   
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Underwear"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Underwear")))))) {
            newClass = keccak256(abi.encodePacked("Painted Underwear"));
        }
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Shirt"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Shirt")))))) {
            newClass = keccak256(abi.encodePacked("Painted Shirt"));
        }
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Hoodie"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Hoodie")))))) {
            newClass = keccak256(abi.encodePacked("Painted Hoodie"));
        }
        if ((((myPiece.pieceClass == keccak256(abi.encodePacked("Snapback"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints",targetPiece.pieceClass))))) || (((myPiece.pieceClass == keccak256(abi.encodePacked("Travel Paints"))) && (targetPiece.pieceClass == keccak256(abi.encodePacked("Snapback")))))) {
            newClass = keccak256(abi.encodePacked("Painted Snapback"));
        }
        //Complete posibilities
        uint rand = randPieceMod(100);
        if (rand <= mergeProbability && myPiece.mergeCount <= maxMerge) {
            _createPiece(newClass, newDna, _curr_loc);
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
            myPiece.mergeCount = myPiece.mergeCount.add(1);
            //burn old piece -> transfer to wallet without secret key
        } if (rand > mergeProbability && myPiece.mergeCount <= maxMerge) {
            _triggerCd(myPiece);
            _triggerCd(targetPiece);
        }
    }
}

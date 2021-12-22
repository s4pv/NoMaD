// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecefactory.sol";

contract PieceInterface{
    function getPiece(uint256 _id) external view returns (
        //Examples of different qualities of the avatar/race that is going to be the couple to our avatar from: NFT collections, other Games, etc.
        //Example: Qualities from Cryptokitties
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract PieceMerging is PieceFactory {

    PieceInterface pieceContract;

    modifier ownerOf(uint _pieceId) {
        require(msg.sender == pieceToOwner[_pieceId]);
        _;
    }

    function setPieceAddress(address _address) external {
        pieceContract = PieceInterface(_address);
    }

    uint pieceMergingFee = 0.1 ether;

    function mergeAndMultiply(uint _PieceId, uint _targetDna, string memory _types) internal ownerOf(_pieceId) payable {
        require(msg.sender == PieceToOwner[_avatarId]);
        require(msg.value == pieceMergingFee);
        Piece storage myPiece = pieces[_avatarId];
        _targetDna = _targetPiece % dnaModulus;
        uint newDna = (myPiece.dna + _targetDna) / 2;
        //pieces cross type?
        _createPiece("NoName", newDna);
    }

    function mergeOnPiece(uint _pieceId, uint _PieceId) public {
        uint pieceDna;
        (,,,,,,,,,pieceDna) = pieceContract.getPiece(_PieceId);
        mergeAndMultiply(_pieceId, pieceDna, _types);
    }
}
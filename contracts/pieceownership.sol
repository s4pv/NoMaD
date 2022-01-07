// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecemerging.sol";
import "./erc721.sol";
import "./safemath.sol";

abstract contract PieceOwnership is PieceMerging, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) Approvals;

  function balanceOf(address _owner) override external view returns (uint256) {
    return ownerPieceCount[_owner];
  }

  function ownerOf(uint256 _tokenId) override external view returns (address) {
    return pieceToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerPieceCount[_to] = ownerPieceCount[_to].add(1);
    ownerPieceCount[msg.sender] = ownerPieceCount[msg.sender].sub(1);
    pieceToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) override external payable {
    require (pieceToOwner[_tokenId] == msg.sender || Approvals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) override external payable onlyOwnerOfPiece(_tokenId) {
    Approvals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

}

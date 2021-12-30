// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";
import "./erc721.sol";
import "./safemath.sol";

abstract contract AvatarOwnership is AvatarBreeding, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) avatarApprovals;

  function balanceOfAvatar(address _owner) override external view returns (uint256) {
    return ownerAvatarCount[_owner];
  }

  function ownerOfAvatar(uint256 _tokenId) override external view returns (address) {
    return avatarToOwner[_tokenId];
  }

  function _transferAvatar(address _from, address _to, uint256 _tokenId) private {
    ownerAvatarCount[_to] = ownerAvatarCount[_to].add(1);
    ownerAvatarCount[msg.sender] = ownerAvatarCount[msg.sender].sub(1);
    avatarToOwner[_tokenId] = _to;
    emit TransferAvatar(_from, _to, _tokenId);
  }

  function transferAvatarFrom(address _from, address _to, uint256 _tokenId) override external payable {
    require (avatarToOwner[_tokenId] == msg.sender || avatarApprovals[_tokenId] == msg.sender);
    _transferAvatar(_from, _to, _tokenId);
  }

  function approveAvatar(address _approved, uint256 _tokenId) override external payable onlyOwnerOfAvatar(_tokenId) {
    avatarApprovals[_tokenId] = _approved;
    emit ApprovalAvatar(msg.sender, _approved, _tokenId);
  }

}

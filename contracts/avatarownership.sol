// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";
import "./erc721.sol";
import "./safemath.sol";

contract AvatarOwnership is AvatarBreeding, ERC721 {

  using SafeMath for uint256;

  mapping (uint => address) Approvals;

  function balanceOf(address _owner) external view returns (uint256) {
    return ownerAvatarCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return avatarToOwner[_tokenId];
  }

  function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerAvatarCount[_to] = ownerAvatarCount[_to].add(1);
    ownerAvatarCount[msg.sender] = ownerAvatarCount[msg.sender].sub(1);
    avatarToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
    require (avatarToOwner[_tokenId] == msg.sender || Approvals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOfAvatar(_tokenId) {
    Approvals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }

}

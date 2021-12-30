// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

abstract contract ERC721 {
  event TransferAvatar(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event ApprovalAvatar(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOfAvatar(address _owner) external view virtual returns (uint256);
  function ownerOfAvatar(uint256 _tokenId) external view virtual returns (address);
  function transferAvatarFrom(address _from, address _to, uint256 _tokenId) external virtual payable;
  function approveAvatar(address _approved, uint256 _tokenId) external virtual payable;

  event TransferPiece(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  event ApprovalPiece(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);

  function balanceOfPiece(address _owner) external view virtual returns (uint256);
  function ownerOfPiece(uint256 _tokenId) external view virtual returns (address);
  function transferPieceFrom(address _from, address _to, uint256 _tokenId) external virtual payable;
  function approvePiece(address _approved, uint256 _tokenId) external virtual payable;
}

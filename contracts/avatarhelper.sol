// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";

contract AvatarHelper is AvatarBreeding {

  modifier aboveAvatarLevel(uint _level, uint _avatarId) {
    require(avatars[_avatarId].avatarLevel >= _level);
    _;
  }
  function withdrawAvatar() external payable onlyOwner {
    require(msg.value == withdrawAvatarFee);
    address _owner = owner();
    payable(_owner).transfer(address(this).balance);
  }
  uint changeAvatarNameFee = 0.1 ether;
  uint changeAvatarDnaFee = 10 ether;
  uint withdrawAvatarFee = 0.01 ether;

  function changeAvatarName(uint _avatarId, string calldata _newName) external payable aboveAvatarLevel(2, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarNameFee);
    avatars[_avatarId].avatarName = _newName;
  }

  function changeAvatarDna(uint _avatarId, uint _newDna) external payable aboveAvatarLevel(10, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarDnaFee);
    avatars[_avatarId].avatarDna = _newDna;
  }

  function getAvatarsByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerAvatarCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < avatars.length; i++) {
      if (avatarToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";

contract AvatarHelper is AvatarBreeding {

  modifier aboveAvatarLevel(uint _level, uint _avatarId) {
    require(avatars[_avatarId].level >= _level);
    _;
  }
  function withdrawAvatar() external onlyOwnerOfAvatar {
    address _owner = owner();
    _owner.transfer(address(this).balance);
  }
  uint changeNameFee = 0.1 ether;
  uint changeDnaFee = 10 ether;

  function changeAvatarName(uint _avatarId, string calldata _newName) external payable aboveAvatarLevel(2, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeNameFee);
    avatars[_avatarId].name = _newName;
  }

  function changeAvatarDna(uint _avatarId, uint _newDna) external payable aboveAvatarLevel(10, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeDnaFee);
    avatars[_avatarId].dna = _newDna;
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

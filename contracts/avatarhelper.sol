// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";

contract AvatarHelper is AvatarBreeding {

  modifier aboveLevel(uint _level, uint _avatarId) {
    require(avatars[_avatarId].level >= _level);
    _;
  }

  function changeName(uint _avatarId, string calldata _newName) external aboveLevel(2, _avatarId) {
    require(msg.sender == avatarToOwner[_avatarId]);
    avatars[_avatarsId].name = _newName;
  }

  function changeDna(uint _avatarId, uint _newDna) external aboveLevel(10, _avatarId) {
    require(msg.sender == avatarToOwner[_avatarId]);
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

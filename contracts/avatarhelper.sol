// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";

contract AvatarHelper is AvatarBreeding {

  modifier avatarTraveled(uint _miles, uint _avatarId) {
    require(avatars[_avatarId].avatarMiles >= _miles);
    _;
  }

    modifier avatarNotTraveledYet(uint _avatarId) {
    require(avatars[_avatarId].avatarMiles = 0);
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
  uint travelFee = 0.01 ether;

  function changeAvatarName(uint _avatarId, string calldata _newName) external payable avatarTraveled(100, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarNameFee);
    avatars[_avatarId].avatarName = _newName;
  }

  function changeAvatarDna(uint _avatarId, uint _newDna) external payable avatarTraveled(100000, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarDnaFee);
    avatars[_avatarId].avatarDna = _newDna;
  }

  function traveledMiles(uint _avatarId, uint ini_loc, uint end_loc) external payable onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == travelFee);
    avatars[_avatarId].avatarMiles = avatars[_avatarId].avatarMiles.add(end_loc - ini_loc);
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

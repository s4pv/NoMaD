// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarbreeding.sol";
import "./safemath.sol";

contract AvatarHelper is AvatarBreeding {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

  modifier avatarTraveled(uint _miles, uint _avatarId) {
    require(avatars[_avatarId].avatarMiles >= _miles);
    _;
  }

  function withdrawAvatar() external payable onlyOwner {
    require(msg.value == withdrawAvatarFee);
    address _owner = owner();
    payable(_owner).transfer(address(this).balance);
  }

  uint changeAvatarNameFee = 0.01 ether;
  uint withdrawAvatarFee = 0.01 ether;
  uint changeAvatarDnaFee = 10 ether;

  function changeAvatarName(uint _avatarId, string calldata _newName) external payable avatarTraveled(100, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarNameFee);
    avatars[_avatarId].avatarName = _newName;
  }

  function changeAvatarDna(uint _avatarId, uint _newDna) external payable avatarTraveled(100000, _avatarId) onlyOwnerOfAvatar(_avatarId) {
    require(msg.value == changeAvatarDnaFee);
    avatars[_avatarId].avatarDna = _newDna;
  }

  function _traveledMiles(uint _avatarId, uint256 _ini_loc, uint256 _end_loc) internal onlyOwnerOfAvatar(_avatarId) {
    avatars[_avatarId].avatarMiles = avatars[_avatarId].avatarMiles.add(_end_loc - _ini_loc);
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

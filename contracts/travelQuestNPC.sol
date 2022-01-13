// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarhelper.sol";
import "./piecehelper.sol";
import "./safemath.sol";

contract TravelQuestNPC is AvatarHelper, PieceHelper {

  using SafeMath for uint256;
  using SafeMath16 for uint16;

  uint changeLocFee = 0.01 ether;
  uint travelFee = 0.01 ether;
  uint16 setHomeCount = 0;
  uint16 setWorkCount = 0;

  function setHomeQuest(uint256 _curr_loc, uint _avatarId) public payable onlyOwnerOfAvatar(_avatarId) {
      require(msg.value == changeLocFee);
      avatars[_avatarId].avatarHome = avatars[_avatarId].avatarHome.add(_curr_loc);
      if(setHomeCount == 0) {
          require(msg.value == createPieceFee * 2);
          _firstHomeSetRewards(_curr_loc);
          setHomeCount = setHomeCount.add(1);
          }
  }

  function setWorkPlaceQuest(uint256 _curr_loc, uint _avatarId) public payable onlyOwnerOfAvatar(_avatarId) {
      require(msg.value == changeLocFee);
      avatars[_avatarId].avatarWorkPlace = avatars[_avatarId].avatarWorkPlace.add(_curr_loc);
      require(msg.value == travelFee);
      _traveledMiles(_avatarId, avatars[_avatarId].avatarHome, avatars[_avatarId].avatarWorkPlace);
      if (setWorkCount == 0) {
          require(msg.value == createPieceFee * 4);
          _firstWorkPlaceSetRewards(_curr_loc);
          _createTravelGift(avatars[_avatarId].avatarWorkPlace, avatars[_avatarId].avatarHome);
          setWorkCount = setWorkCount.add(1);
           //travel tokens rewards
      }
  }

  function workTravelQuest(uint256 _curr_loc, uint _avatarId) public payable onlyOwnerOfAvatar(_avatarId) {
      if (_curr_loc - avatars[_avatarId].avatarWorkPlace < 1 || _curr_loc - avatars[_avatarId].avatarHome < 1) {
          require(msg.value == createPieceFee);
          _createTravelGift(avatars[_avatarId].avatarWorkPlace, avatars[_avatarId].avatarHome);
          require(msg.value == travelFee);
          _traveledMiles(_avatarId, avatars[_avatarId].avatarHome, avatars[_avatarId].avatarWorkPlace);
          //travel token rewards
      }
  }

  function travelQuest(uint256 _curr_loc, uint256 _last_loc, uint _avatarId) public payable onlyOwnerOfAvatar(_avatarId) {
      require(msg.value == createPieceFee);
      _createTravelGift(_curr_loc, _last_loc);
      require(msg.value == travelFee);
      _traveledMiles(_avatarId, _curr_loc, _last_loc);
      // travel tokens rewards
  }

  function workQuest(uint256 _curr_loc, uint _avatarId) public onlyOwnerOfAvatar(_avatarId) {
      if(_curr_loc - avatars[_avatarId].avatarWorkPlace < 1) {
          //start minning work tokens with devices
      }
  }
}

//c_no_mad_
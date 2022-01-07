// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./piecehelper.sol";
import "./avatarhelper.sol";

contract questNPC is PieceHelper, AvatarHelper {

  uint changeLocFee = 0.01 ether;

  function setHomeQuest(uint256 _curr_loc, uint _avatarId) public onlyOwnerOfAvatar(_avatarId) {
      require(msg.value == changeLocFee);
      avatars[_avatarId].avatarHome = avatars[_avatarId].avatarHome.add(_curr_loc);
      createBlankUnderWear();
      createBlankSocks();
  }

  function setWorkPlaceQuest(uint _curr_loc, uint _avatarId) public onlyOwnerOfAvatar(_avatarId) avatarNotTraveledYet(_avatarId) {
      require(msg.value == changeLocFee);
      avatars[_avatarId].avatarWorkPlace = avatars[_avatarId].avatarWorkPlace.add(_curr_loc);
      createTravelGift(avatars[_avatarId].avatarWorkPlace, avatars[_avatarId].avatarHome);
      traveledMiles(avatars[_avatarId].avatarHome, avatars[_avatarId].avatarWorkPlace);
      createBlankShirt();
      createBlankSPants();
      createBlankShoes();
      //travel tokens rewards
  }


  function workTravelQuest(uint256 _curr_loc, uint _avatarId) public onlyOwnerOfAvatar(_avatarId) {
      if (_curr_loc - avatars[_avatarId].avatarWorkPlace < 0.1 || _curr_loc - avatars[_avatarId].avatarHome < 0.1) {
         createTravelGift(avatars[_avatarId].avatarWorkPlace, avatars[_avatarId].avatarHome);
         traveledMiles(avatars[_avatarId].avatarHome, avatars[_avatarId].avatarWorkPlace);
          //travel token rewards
      }
  }

  function travelQuest(uint256 _curr_loc, uint256 _last_loc) public onlyOwnerOfAvatar(_avatarId) {
      createTravelGift(_curr_loc, _last_loc);
      traveledMiles(_curr_loc, _last_loc);
      // travel tokens rewards
  }

  function workQuest(uint256 _curr_loc) public onlyOwnerOfAvatar(_avatarId) {
      if(_curr_loc - avatars[_avatarId].avatarWorkPlace < 0.1) {
          //start minning work tokens with devices
          }
  }

}

//c_no_mad_
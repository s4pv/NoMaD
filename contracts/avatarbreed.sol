// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarhelper.sol";
//not secure
contract AvatarBreed is AvatarHelper {
  uint randNonce = 0;
  uint breedProbability = 90;
  uint maxBreed = 7;
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _modulus;
  }

  function breed(uint _avatarId, uint _targetAvatarId) external ownerOf(_avatarId) {
    Avatar storage myAvatar = avatars[_avatarId];
    Avatar storage enemyAvatar = avatars[_targetId];
    uint rand = randMod(100);
    if (rand <= breedProbability && myAvatar.breedCount <= maxBreed) {
      feedAndMultiply(_avatarId,_targetAvatar.dna, "cypherpunk"); //modify later to a cross species
    } else if (rand > breedProbability && myAvatar.breedCount <= maxBreed){
    }
      myAvatar.breedCount++;
    _triggerCooldown(myAvatar);
  }
}
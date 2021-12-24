// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarmigration.sol";

contract AvatarBreeding is AvatarMigration {

     uint breedProbability = 90;
     uint maxBreed = 7;
    modifier onlyOwnerOfAvatar(uint _avatarId) {
        require(msg.sender == avatarToOwner[_avatarId]);
        _;
    }

    function _triggerCd(Avatar storage _avatar) internal {
        _avatar.readyTime = uint32(now + avatarCdTime);
    }

    function _isReady(Avatar storage _avatar) internal view returns (bool) {
       return (_avatar.readyTime <= now);
    }

    uint breedFee = 1 ether; //live tokens

    function breed(uint _avatarId, uint _targetAvatarId) internal onlyOwnerOfAvatar(_avatarId) onlyOwnerOfAvatar(_targetAvatarId) payable {
        Avatar storage myAvatar = avatars[_avatarId];
        Avatar storage targetAvatar = avatars[_targetAvatarId];
        require(_isReady(myAvatar));
        require (_isReady(targetAvatar));
        require(msg.value == breedFee);
        uint newDna = (myAvatar.avatarDna + targetAvatar.avatarDna) / 2;
        uint newRace;
        if ((myAvatar.avatarRace == "cypherPunk" && targetAvatar.avatarRace == "traveler") || (myAvatar.avatarRace == "traveler" && targetAvatar.avatarRace == "cypherPunk")) {
            newRace = "cypherTraveler";
        }
        if ((myAvatar.avatarRace == "kitty" && targetAvatar.avatarRace == "traveler") || (myAvatar.avatarRace == "traveler" && targetAvatar.avatarRace == "kitty")) {
            newRace = "kittyTraveler";
        }
        if ((myAvatar.avatarRace == "boredApe" && targetAvatar.avatarRace == "traveler") || (myAvatar.avatarRace == "traveler" && targetAvatar.avatarRace == "boredApe")) {
            newRace = "boredAvatar";
        }
        if ((myAvatar.avatarRace == "cypherPunk" && targetAvatar.avatarRace == "kitty") || (myAvatar.avatarRace == "kitty" && targetAvatar.avatarRace == "cypherPunk")) {
            newRace = "cypherKitty";
        }
        if ((myAvatar.avatarRace == "cypherPunk" && targetAvatar.avatarRace == "boredApe") || (myAvatar.avatarRace == "boredApe" && targetAvatar.avatarRace == "cypherPunk")) {
            newRace = "cypherApe";
        }
        if ((myAvatar.avatarRace == "kitty" && targetAvatar.avatarRace == "boredApe") || (myAvatar.avatarRace == "boredApe" && targetAvatar.avatarRace == "kitty")) {
            newRace = "kitty";
        }
        if (myAvatar.avatarRace == "traveler" && targetAvatar.avatarRace == "traveler") {
            newRace = "traveler";
        }
        else {
            newRace = "newRaces";
        }
        uint rand = randMod(100);
        if (rand <= breedProbability && myAvatar.breedCount <= maxBreed) {
            _createAvatar("NoName", newRace, _randSex(), newDna);
            _triggerCd(myAvatar);
            _triggerCd(targetAvatar);
            myAvatar.breedCount++;
        } else if (rand <= breedProbability && myAvatar.breedCount <= maxBreed) {
            _createAvatar("NoName", newRace, _randSex(), newDna);
            _triggerCd(myAvatar);
            _triggerCd(targetAvatar);
            myAvatar.breedCount++;
        }
    }
}

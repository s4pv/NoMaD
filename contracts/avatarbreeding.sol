// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarmigration.sol";
import "./safemath.sol";

contract AvatarBreeding is AvatarMigration {

    using SafeMath16 for uint16;

    uint breedProbability = 90;
    uint maxBreed = 7;
    modifier onlyOwnerOfAvatar(uint _avatarId) {
        require(msg.sender == avatarToOwner[_avatarId]);
        _;
    }

    function _triggerCd(Avatar storage _avatar) internal {
        _avatar.avatarReadyTime = uint32(block.timestamp + avatarCdTime);
    }

    function _isReady(Avatar storage _avatar) internal view returns (bool) {
       return (_avatar.avatarReadyTime <= block.timestamp);
    }

    uint breedFee = 0.3 ether; //live tokens

    function breed(uint _avatarId, uint _targetAvatarId) public onlyOwnerOfAvatar(_avatarId) onlyOwnerOfAvatar(_targetAvatarId) payable {
        Avatar storage myAvatar = avatars[_avatarId];
        Avatar storage targetAvatar = avatars[_targetAvatarId];
        require(_isReady(myAvatar));
        require (_isReady(targetAvatar));
        require(msg.value == breedFee);
        uint newDna = (myAvatar.avatarDna + targetAvatar.avatarDna) / 2;
        bytes32 newRace;
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("traveler")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("traveler"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))))) {
            newRace = keccak256(abi.encodePacked("cypherTraveler"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("traveler")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("traveler"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))))) {
            newRace = keccak256(abi.encodePacked("kittyTraveler"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("traveler")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("traveler"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))))) {
            newRace = keccak256(abi.encodePacked("boredTraveler"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("kitty")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))))) {
            newRace = keccak256(abi.encodePacked("cypherKitty"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("boredApe")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))))) {
            newRace = keccak256(abi.encodePacked("cypherApe"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("boredApe")))) || ((myAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))))) {
            newRace = keccak256(abi.encodePacked("kitty"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("traveler"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("traveler"))))) {
            newRace = keccak256(abi.encodePacked("traveler"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("kitty"))))) {
            newRace = keccak256(abi.encodePacked("kitty"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("boredApe"))))) {
            newRace = keccak256(abi.encodePacked("boredApe"));
        }
        if (((myAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))) && (targetAvatar.avatarRace == keccak256(abi.encodePacked("cypherPunk"))))) {
            newRace = keccak256(abi.encodePacked("cypherPunk"));
        }
        else {
            newRace = keccak256(abi.encodePacked("newRaces"));
        }
        uint rand = randAvatarMod(100);
        if (rand <= breedProbability && myAvatar.breedCount <= maxBreed) {
            _createAvatar(newRace, _randSex(), newDna);
            _triggerCd(myAvatar);
            _triggerCd(targetAvatar);
            myAvatar.breedCount = myAvatar.breedCount.add(1);
        } if (rand > breedProbability && myAvatar.breedCount <= maxBreed) {
            _triggerCd(myAvatar);
            _triggerCd(targetAvatar);
            myAvatar.breedCount = myAvatar.breedCount.add(1);
        }
    }
}

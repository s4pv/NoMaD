// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./avatarfactory.sol";

contract AvatarInterface{
    function getAvatar(uint256 _id) external view returns (
        //Examples of different qualities of the avatar/race that is going to be the couple to our avatar from: NFT collections, other Games, etc.
        //Example: Qualities from Cryptokitties
        bool isGestating,
        bool isReady,
        uint nextActionAt,
        uint256 cooldownIndex,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract AvatarBreeding is AvatarFactory {

    AvatarInterface avatarContract;

    modifier ownerOf(uint _avatarId) {
        require(msg.sender == avatarToOwner[_avatarId]);
        _;
    }

    function setAvatarAddress(address _address) external {
        avatarContract = AvatarInterface(_address);
    }

    function _triggerCooldown(Avatar storage _avatar) internal {
        _avatar.readyTime = uint32(now + cooldownTime);
    }

    function _isReady(Avatar storage _avatar) internal view returns (bool) {
       return (_avatar.readyTime <= now);
    }

    uint breedFee = 0.9 ether; //live tokens; add travel tokens also

    function breedAndMultiply(uint _AvatarId, uint _targetDna, string memory _species) internal ownerOf(_avatarId) payable {
        require(msg.value == breedFee);
        Avatar storage myAvatar = avatars[_avatarId];
        require(_isReady(myAvatar));
        _targetDna = _targetAvatar % dnaModulus;
        uint newDna = (myAvatar.dna + _targetDna) / 2;
        //avatar cross races?
        _createAvatar("NoName", newDna);
        _triggerCooldown(myAvatar);
    }

    function breedOnAvatar(uint _avatarId, uint _AvatarId) public {
        uint avatarDna;
        (,,,,,,,,,avatarDna) = avatarContract.getAvatar(_AvatarId);
        breedAndMultiply(_avatarId, avatarDna, _species);
    }
}
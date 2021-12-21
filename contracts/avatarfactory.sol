// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";

contract AvatarFactory is Ownable {

    event NewAvatar(uint avatarId, string name, uint dna);
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Avatar {
        string name;
        string race;
        string sex;
        uint dna;
        uint age;
        uint32 level;
        uint32 readyTime;
    }

    Avatar[] public avatars;

    mapping (uint => address) public avatarToOwner;
    mapping (address => uint) ownerAvatarCount;

    function _createAvatar(string memory _name, uint _dna) internal {
        uint id = avatars.push(Avatar(_name, _dna), uint32(now + cooldownTime)) -1;
        avatarToOwner[id] = msg.sender;
        ownerAvatarCount[msg.sender]++;
        emit NewAvatar(id, _name, _dna);
    }

    function _generateRandomDna(string memory_str) private views returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomAvatar(string memory _name) public {
        require(ownerAvatarCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createAvatar(_name, randDna);
    }
}
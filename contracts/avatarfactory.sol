// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";

contract AvatarFactory is Ownable {

    event NewAvatar(uint avatarId, string avatarName, string avatarRace, string avatarSex, uint avatarDna, uint32 avatarReadyTime, uint8 avatarAge, uint8 avatarLevel,  uint8 avatarLuck, uint8 avatarInt, uint8 avatarAgi, uint8 avatarStr, uint8 avatarSta, uint8 avatarBreedCount);

    uint avatarDnaDigits = 16;
    uint avatarDnaModulus = 10 ** avatarDnaDigits;
    uint avatarCdTime = 1 days;

    struct Avatar {
        string avatarName;
        string avatarRace;
        string avatarSex;
        uint32 avatarReadyTime;
        uint avatarDna;
        uint8 avatarAge;
        uint8 avatarLevel;
        uint8 avatarLuck;
        uint8 avatarIntellect;
        uint8 avatarAgility;
        uint8 avatarStrength;
        uint8 avatarStamina;
        uint8 breedCount;
    }

    Avatar[] public avatars;

    mapping (uint => address) public avatarToOwner;
    mapping (address => uint) ownerAvatarCount;

    uint avatarCreationFee = 1 ether;
    uint randNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(now,msg.sender,randNonce))) % _modulus;
    }

    function _randSex() internal returns(string) {
        uint maleProbability = 50;
        string _sex;
        if (randMod(100) <= maleProbability) {
            _sex = "male";
        } else {
            _sex = "female";
        }
        return (_sex);
    }

    function _createAvatar(string memory _name, string _race, string _sex, uint _dna) internal payable {
        require(msg.value == avatarCreationFee);
        uint32 _readyTime = uint32(now + avatarCdTime);
        uint8 _age = 1;
        uint8 _lvl = 1;
        uint8 _luk = 1;
        uint8 _int = 1;
        uint8 _agi = 1;
        uint8 _str = 1;
        uint8 _sta = 1;
        uint8 _breedCount = 0;
        uint avatarId = avatars.push(Avatar(_name, _race, _sex, _dna, _readyTime, _age, _lvl, _luk, _int, _agi, _str, _sta, _breedCount)) - 1;
        avatarToOwner[avatarId] = msg.sender;
        ownerAvatarCount[msg.sender]++;
        emit NewAvatar(avatarId, _name, _race, _sex, _dna, _readyTime, _age, _lvl, _luk, _int, _agi, _str, _sta, _breedCount);
    }

    function _generateRandomAvatarDna(string memory _str) private view returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % avatarDnaModulus;
    }

    function createRandomAvatar(string memory _name, string _sex) public {
        require(ownerAvatarCount[msg.sender] == 0);
        string _race = "traveler";
        uint randDna = _generateRandomAvatarDna(_name);
        randDna = randDna - randDna % 100;
        _createAvatar(_name, _race, _sex, randDna);
    }
}
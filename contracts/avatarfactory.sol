// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./ownable.sol";
import "./safemath.sol";

contract AvatarFactory is Ownable {

    using SafeMath for uint256;
    using SafeMath32 for uint32;
    using SafeMath16 for uint16;

    event NewAvatar(uint avatarId, uint avatarDna, string avatarName, string avatarSex, bytes32 avatarRace, uint32 avatarReadyTime, uint16 avatarLevel,  uint16 avatarLuck, uint16 avatarInt, uint16 avatarAgi, uint16 avatarStr, uint16 avatarSta, uint16 avatarBreedCount);

    uint avatarDnaDigits = 16;
    uint avatarDnaModulus = 10 ** avatarDnaDigits;
    uint avatarCdTime = 1 days;

    struct Avatar {
        uint avatarDna;
        string avatarName;
        string avatarSex;
        bytes32 avatarRace;
        uint32 avatarReadyTime;
        uint16 avatarLevel;
        uint16 avatarLuck;
        uint16 avatarIntellect;
        uint16 avatarAgility;
        uint16 avatarStrength;
        uint16 avatarStamina;
        uint16 breedCount;
    }

    Avatar[] public avatars;

    mapping (uint => address) public avatarToOwner;
    mapping (address => uint) ownerAvatarCount;

    uint avatarCreationFee = 1 ether;
    uint randNonce = 0;

    function randMod(uint _modulus) internal returns(uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender,randNonce))) % _modulus;
    }

    function _randSex() internal returns(string memory) {
        uint maleProbability = 50;
        string memory _sex;
        if (randMod(100) <= maleProbability) {
            _sex = "male";
        } else {
            _sex = "female";
        }
        return (_sex);
    }

    function _createAvatar(bytes32 _race, string memory _sex, uint _dna) internal {
        uint32 _readyTime = uint32(block.timestamp + avatarCdTime);
        // Note: We chose not to prevent the year 2038 problem... So don't need
        // worry about overflows on readyTime. Our app is screwed in 2038 anyway ;)
        avatars.push(Avatar(_dna, "NoName", _sex, _race, _readyTime, 1, 1, 1, 1, 1, 1, 0));
        uint avatarId = avatars.length -1;
        avatarToOwner[avatarId] = msg.sender;
        ownerAvatarCount[msg.sender] = ownerAvatarCount[msg.sender].add(1);
        emit NewAvatar(avatarId, _dna, "NoName", _sex, _race, _readyTime, 1, 1, 1, 1, 1, 1, 0);
    }

    function _generateRandomAvatarDna(string memory _str) private view returns (uint) {
        uint rand = uint (keccak256(abi.encodePacked(_str)));
        return rand % avatarDnaModulus;
    }

    function createRandomAvatar(string memory _name, string memory _sex) public payable {
        require(msg.value == avatarCreationFee);
        require(ownerAvatarCount[msg.sender] == 0);
        bytes32 _race = keccak256(abi.encodePacked("traveler"));
        uint randDna = _generateRandomAvatarDna(_name);
        randDna = randDna - randDna % 100;
        _createAvatar(_race, _sex, randDna);
    }
}
pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract CrewMember is ERC721 {
    struct Member {
        bytes24 name;
        uint8 jobID;
        uint8 skill;
        uint8 hair;
        uint8 face;
        uint8 skin;
        uint8 outfit;
    }
    Member s_member;
}
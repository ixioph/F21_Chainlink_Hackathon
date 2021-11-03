pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';

contract Component is ERC721 {
    struct Part {
        bytes24 name;
        uint8 typeID;
        uint8 subtypeID;
        uint8 quality;
        uint8 c1;
        uint8 c2;
        uint8 c3;
    }
    Part s_part;
}
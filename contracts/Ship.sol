pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';

contract Ship is ERC1155 {
    struct Build {
        bytes22 name;
        uint8 body;
        uint8 speed;
        uint8 energy;
        uint8 combat;
        uint8 salvage;
        uint8 crew;
        uint8 bays;
        uint8 c1;
        uint8 c2;
        uint8 c3;
    }
    Build s_ship;
    Component[] public s_shipParts;
    CrewMember[] public s_shipCrew;

    constructor("Space Ship", "SHIP") {
        // ...
    }

    remove_part();
    remove_crew();
    add_part();
    add_crew();
    swap_part();
    swap_crew();
    rest();
}
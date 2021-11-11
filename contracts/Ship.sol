pragma solidity >=0.7.0 <0.9.0;

import '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import '@chainlink/contracts/src/v0.8/VRFConsumerBase.sol';

contract Ship is ERC1155, VRFConsumerBase {
    uint256 public tokenCounter;
    bytes32 keyHash;
    uint256 internal fee;
    uint256 public randomResult;

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
    //Build s_ship;
    Component[] public s_shipParts;
    CrewMember[] public s_shipCrew;

    // mappings
    mapping(bytes32 => address) public requestIdToSender;
    mapping(bytes32 => string) public requestIdToTokenURI;
    mapping(uint256 => Build) public tokenIdToShip;
    mapping(bytes32 => uint256) public requestIdToTokenId;
    mapping(uint256 => uint256) public partIdToShipId;
    mapping(uint256 => uint256) public crewIdToShipId;


    constructor(address _VRFCoordinator, address _link, bytes32 _keyhash) public 
    VRFConsumerBase(_VRFCoordinator, _link) 
    ERC1155("Space Ship", "SHIP") {
        tokenCounter = 0;
        keyHash = _keyhash;
        fee = 0.1 * 10**18;
    }

    function createCollectible(string memory tokenURI, uint256 seed) public 
    returns (bytes32){
        bytes32 requestId = requestRandomness(keyHash, fee, seed);
        requestIdToSender[requestId] = msg.sender;
        requestIdToTokenURI[requestId] = tokenURI;
        // ...
    }

    function fulfillRandomness(bytes32 requestId, uint256 rNum) internal override {
        address shipOwner = requestIdToSender[requestId];
        string memory tokenURI = requestIdToTokenURI[requestId];
        uint256 itemId = tokenCounter;
        _safeMint(shipOwner, itemId);
        _setTokenURI(itemId, tokenURI);
        // break rNum up and use to populate Build variables
        Build ship = Build();
        tokenIdToShip[itemId] = ship;
        requestIdToTokenId[requestId] = itemId;
    }

    function remove_part(uint256 partId, uint256 shipId) {
        partIdToShipId[partId] = null; // note: how do we treat "empty" parts? 
    }
    function remove_crew(uint256 crewId, uint256 shipId) {
        crewIdToShipId[partId] = null; // ...
    }

    // note: remove ship part functionality for time constraints?
    add_part();
    add_crew();
    swap_part();
    swap_crew();
    rest();
}
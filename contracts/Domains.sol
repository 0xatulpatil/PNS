// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Domains {
    //mapping to store their names
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor() {
        console.log("THIS IS MY DOMAINS CONTRACT. NICE.");
    }

    //register function that adds their names to the map

    function register(string calldata name) public {
        require(domains[name] == address(0));
        domains[name] = msg.sender;
        console.log("%s has registered a domain!", msg.sender);
    }

    //function to get the address of the domain owner

    function getAddress(string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require(domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name)
        public
        view
        returns (string memory)
    {
        return records[name];
    }
}

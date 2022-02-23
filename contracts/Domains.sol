// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import {StringUtils} from "./libraries/StringUtils.sol";
import "hardhat/console.sol";

contract Domains {
    string public dob;
    //mapping to store their names
    mapping(string => address) public domains;
    mapping(string => string) public records;

    constructor(string memory _dob) payable {
        dob = _dob;
        console.log("%s name service deployed", _dob);
    }

    //function to give us the price based on the length
    function price(string calldata name) public pure returns (uint256) {
        uint256 len = StringUtils.strlen(name);
        require(len > 0);
        if (len == 3) {
            return 5 * 10**17; //5 MATIC
        } else if (len == 4) {
            return 3 * 10**17; //0.3 MATIC
        } else {
            return 1 * 10 * 17; //0.1 MATIC
        }
    }

    //register function that adds their names to the map

    function register(string calldata name) public payable {
        require(domains[name] == address(0));

        uint256 _price = price(name);

        require(msg.value >= _price, "Not enough Matic");

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

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

contract MyCryptoLions is ERC721 {
    constructor(string memory name, string memory symbol)
        ERC721(name, symbol)
    {
        console.log("name",name);
        console.log("symbol",symbol);
        console.log("msg.sender", msg.sender);
    }
}
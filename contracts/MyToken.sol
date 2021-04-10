// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor() ERC20("Virtuosa", "VIA"){
        _mint(msg.sender, 21000);
    }
}
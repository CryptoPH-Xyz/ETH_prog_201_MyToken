// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

contract MPCToken is ERC20PresetMinterPauser {
//added a cap setter role
    bytes32 public constant CAPSETTER_ROLE = keccak256("CAPSETTER_ROLE");
    uint256 private _cap;

    constructor(uint256 cap_) ERC20PresetMinterPauser("Virtuosa", "VIA"){
        _setupRole(CAPSETTER_ROLE, _msgSender());
        
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }
    
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    function _mint(address account, uint256 amount) internal virtual override {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }
//modified this function below
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20PresetMinterPauser) {
        super._beforeTokenTransfer(from, to, amount);
        require(from == address(0), "Only Admin can mint Tokens");
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");      
    }
//added a new function which only allows cap setter to change token cap
    function setCap(uint _newCap) public {
        require(hasRole(CAPSETTER_ROLE, _msgSender()), "ERC20PresetMinterPauser: must have cap setter role to change cap");
        require(_newCap > ERC20.totalSupply(),"New Cap should be more than Total Supply");
        require(_newCap > 0, "Token Cap is 0");
        _cap = _newCap;
    }
}
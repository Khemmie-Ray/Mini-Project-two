// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./interfaceToken.sol";

contract ERC20 is IERC20 {
    uint public override totalSupply;
    mapping(address => uint) public override balanceOf;
    mapping(address => mapping(address => uint)) public override allowance;
    string public name = "Tech4Dev Tokens";
    string public symbol = "T4D";
    uint8 public decimals = 18;

// This function moves a particular amount of tokens from the owner's account to a recipient.

    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

// This function sets an amount as the allowance of spender from the owner's account.

     function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

// This function moves an amount of token from sender to recipient using the allowance mechanism, amount is then deducted from the caller's allowance. 

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

// This function allows the owner to generate new T4D tokens.

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

// This function is for the destruction of the T4D tokens.

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}
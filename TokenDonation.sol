// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
}

contract TokenDonation {
    address public tokenAddress;

    constructor(address _tokenAddress) {
        tokenAddress = _tokenAddress;
    }

    function donateTokens(address recipient, uint256 amount) public {
        IERC20 token = IERC20(tokenAddress);

        uint256 allowance = token.allowance(msg.sender, address(this));
        require(allowance >= amount, "Allowance not sufficient");

        uint256 balance = token.balanceOf(msg.sender);
        require(balance >= amount, "Insufficient balance");

        require(token.transferFrom(msg.sender, recipient, amount), "Transfer failed");
    }
}
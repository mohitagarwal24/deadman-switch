// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DeadmanSwitch {
    address public owner;
    address public beneficiary;
    uint public lastCheckIn;
    uint public constant CHECK_IN_BLOCKS = 10;

    error OnlyOwner();
    error StillActive();

    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckIn = block.number;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert OnlyOwner();
        _;
    }

    function stillAlive() external onlyOwner {
        lastCheckIn = block.number;
    }

    function checkStatus() external {
        if (block.number - lastCheckIn <= CHECK_IN_BLOCKS) revert StillActive();
        payable(beneficiary).transfer(address(this).balance);
    }

    receive() external payable {}
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/DeadmanSwitch.sol";

contract Deploy is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address beneficiary = vm.envAddress("BENEFICIARY");
        
        vm.startBroadcast(deployerPrivateKey);
        new DeadmanSwitch(beneficiary);
        vm.stopBroadcast();
    }
}
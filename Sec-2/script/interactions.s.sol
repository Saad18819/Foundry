// SPDX-License-Identifier: MIT

// here we gonna write all of the ways we can actually interact with our contract
pragma solidity ^0.8.19;

import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe4} from "../src/FundMe4.sol";

contract FundFundMe is Script{
    
uint256 constant SEND_VALUE = 0.01 ether;


function fundFundMe(address mostRecentlyDeployed) public {
    // Give the caller or script contract 1 ETH to send
    vm.deal(msg.sender, 1 ether);
    
    vm.startBroadcast();
    FundMe4(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
    vm.stopBroadcast();

    console.log("Funded FundMe contract with %s", SEND_VALUE);
}

 function run() external{
      
 address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
   vm.startBroadcast();
 fundFundMe(mostRecentlyDeployed);
    vm.stopBroadcast();
 }
}


contract WithdrawFundMe is Script{
uint256 constant SEND_VALUE = 0.01 ether;

    function withdrawFundMe(address mostRecentlyDeployed) public{

vm.startBroadcast();
   FundMe4(payable(mostRecentlyDeployed)).withdraw();
 vm.stopBroadcast();

   console.log("Withdrew FundMe contract with %s",SEND_VALUE);
}


 function run() external{
      
 address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe4", block.chainid);
   vm.startBroadcast();
 withdrawFundMe(mostRecentlyDeployed);
    vm.stopBroadcast();
 }
}


/*
1)in cmnd write (its foundry devops)
forge install ChainAccelOrg/foundry-devops

after that write import of devops
basically foundry DevOps is a tool that i use to actually grab my most recently deployed contract
this package helpy ur foundry to keep track of the most recently deployed version of contract


2)in foundry.toml make changes write ffi =true

this means u allow foundry to run commands directly on ur machine
but just a word of caution i recommend u to keep this off as long as possible
just to know how it works and how we can use it we keeping it ON for now


3)in test make 2 new folder integration and unit
and inside unit make test file 
and we going with FundMeTest5.t.sol and DeployFundMe5.s.sol

 */
// SPDX-License-Identifier: MIT

// here we gonna write everything like how we gonna interact with our contract
pragma solidity ^0.8.19;

import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe4} from "../src/FundMe4.sol";

contract FundFundMe is Script{
    
uint256 constant SEND_VALUE = 0.01 ether;

function fundFundMe(address mostRecentlyDeployed) public{

    vm.startBroadcast();
   FundMe4(payable(mostRecentlyDeployed)).fund{value:SEND_VALUE}();
   vm.stopBroadcast();
   console.log("Funded FundMe contract with %s",SEND_VALUE);
}


 function run() external{
 address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
 fundFundMe(mostRecentlyDeployed);
 }
}


contract WithdrawFundMe is Script{}


/*
1)in cmnd write (its foundry devops)
forge install ChainAccelOrg/foundry-devops

after that write import of devops

2)in foundry.toml make changes write ffi =true
this means u allow foundry to run commands directly on ur machine


3)in test make 2 new folder integration and unit
and inside unit make test file 
and we going with FundMeTest5.t.sol and DeployFundMe5.s.sol

 */
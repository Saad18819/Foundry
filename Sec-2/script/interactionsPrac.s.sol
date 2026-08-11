// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe4} from "../src/FundMe4.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract fundFundMe is Script{
    uint256 constant SEND_ETHER = 0.1;

    function funding(address recentDeployedAddress) public{

        vm.deal(msg.sender , 1 ether);

        vm.startBroadcast();
        FundMe4(payable(recentDeployedAddress)).fund{value:SEND_ETHER}();
        vm.stopBroadcast();

    }

function run() external{

address mostrecentlyDeployedAddress = DevOpsTools.get_most_recent_deployment("FundMe4", block.chainid);

vm.startBroadcast();
funding(mostrecentlyDeployedAddress);
vm.stopBroadcast();

}

contract withdrawFundMe() is Script{


function withdrawing(address recentlyDeployedAddress) public{

    vm.startBroadcast();
    FundMe4(payable(recentlyDeployedAddress)).withdraw();
    vm.stopBroadcast();
}

function run() external{
    address mostrecentlyDeployedAddress = DevOpsTools.get_most_recent_deployment("FundMe4", block.chainid);

    vm.startBroadcast();
    withdrawing(mostrecentlyDeployedAddress);
    vm.stopBroadcast();
}



}


}
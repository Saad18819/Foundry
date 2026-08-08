// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe4} from "../src/FundMe4.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe5 is Script{



function run() external returns(FundMe4){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe4 fundMe = new FundMe4(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}


/*
PROPER EXPLANATION ABT THESE INTEGRATION TEST

so basically if we wanna test this architecture first we will write the command in terminal to fund out contract and then withdraw logic to test if its workng or not since yaha pe code is small toh it was fine but if code is way too lengthy what u gonna do





 */
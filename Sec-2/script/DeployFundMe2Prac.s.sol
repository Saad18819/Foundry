// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe1Prac} from "../src/FundMe1Prac.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe2Prac is Script{



function run() external returns(FundMe1Prac){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe1Prac fundMe = new FundMe1Prac(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}
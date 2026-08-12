// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe2Prac} from "../src/FundMe2Prac.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe3Prac is Script{



function run() external returns(FundMe2Prac){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe2Prac fundMe = new FundMe2Prac(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}
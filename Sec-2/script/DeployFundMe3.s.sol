// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe2} from "../src/FundMe2.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe3 is Script{



function run() external returns(FundMe2){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe2 fundMe = new FundMe2(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}
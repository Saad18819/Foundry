// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe3} from "../src/FundMe3.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe4 is Script{



function run() external returns(FundMe3){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe3 fundMe = new FundMe3(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}






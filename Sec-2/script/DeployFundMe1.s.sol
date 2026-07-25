// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe1} from "../src/FundMe1.sol";

contract DeployFundMe is Script{

function run() external{
    vm.startBroadcast();
    FundMe1 fundMe = new FundMe1(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    vm.stopBroadcast();
}
}

// the inside address means apan ne construtor me parameter diya tha so deploy karne ke time whichever address i wanna use voh we gotaa put in consider it type of remix jaha pe before deploying it will ask for address so just ike that we are giving it the address



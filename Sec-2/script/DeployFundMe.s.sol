// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script{

function run() external{
    vm.startBroadcast();
    FundMe fundMe = new FundMe();
    vm.stopBroadcast();
}
}

// after writing this code in terminal write command to cdeploy the Fundme.sol contract
// forge script script/DeployFundMePrac.sol:DeployFundMe
// forge script path:contractName


// When you execute FundMe fundMe = new FundMe();, the new keyword takes that specific blueprint(code from src folder), compiles it into bytecode, and deploys a live instance(take the design from src file and actually deploy it) of your actual src/FundMe.sol contract onto the blockchain network.
//Your FundMe.sol file is the DNA layout. It is just text information sitting on your hard drive.
//When you use the new keyword, you are giving that DNA to the blockchain factory. The blockchain reads the blueprint, builds a brand new, functional clone out of it, sparks it into existence, and gives it a home (a contract address).


// OR SIMPLE ANLAOGY IS Your FundMe.sol file in the src folder is like a draft email you wrote. It's just sitting there as text. When you use the new keyword, it is like hitting "Send."
// If you send that email to three different people, each person gets their own distinct copy of that email in their inbox. Even though all three emails contain the exact same text, they now live at different email addresses, and if one person deletes their email, it doesn't affect the other two.
//Every time you execute new FundMe(), you are sending a new copy out into the blockchain, and it gets its own unique address where it permanently lives. You nailed it!


// after this go to test folder FundMeTest1.t.sol
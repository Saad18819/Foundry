// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe1} from "../src/FundMe1.sol";

// we are adding this
import {DeployFundMe2} from "../script/DeployFundMe2.s.sol";


contract FundMeTest is Test{

FundMe1 fundme;

uint256 num = 1;

function setUp() external{
DeployFundMe2 deployFundMe = new DeployFundMe2(); // this is just the blueprint of contract is made
fundme = deployFundMe.run(); // here u are actually calling it
num =2;
}

function testDemo() public{
    console.log("Hello Ji");
    assertEq(num , 2);
}

function testMinUsd() public{
    assertEq(fundme.MINIMUM_USD() , 5e18);
}

function testOwner() public{
    assertEq(fundme.i_owner(),msg.sender);
}

function testgetVersion() public{
    assertEq(fundme.getVersion() , 4);
}

}


/*
1) make DeployFundMe2.s.sol file
2)in here add "import {DeployFundMe} from "../script/DeployFundMe2.s.sol";"
3) now go to this file DeployFundMe2.s.sol
4)now in function setup we did changes
5)also in testowner replace address(this) with msg.sender
6)and then in cmnd run the test to check "forge test --fork-url $SEPOLIA_RPC_URL" or mainnet or just "fork test" coz we have anvil with us and u will realise anvil works so fast like coz it doesnt have to do API call




 */
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe1Prac} from "../src/FundMe1Prac.sol";

import {DeployFundMe2Prac} from "../script/DeployFundMe2Prac.s.sol";

contract FundMeTest is Test{

FundMe1Prac fundme;

uint256 num = 1;

function setUp() external{
DeployFundMe2Prac depFund = new DeployFundMe2Prac();
fundme = depFund.run();
}

function testDemo() public{
    console.log("Hello Ji");
    assertEq(num , 1);
}

function testMinUsd() public{
    assertEq(fundme.MINIMUM_USD() , 5e18);
}

function testOwner() public{
    assertEq(fundme.i_owner(),address(this));
}

function testgetVersion() public{
    assertEq(fundme.getVersion() , 4);
}

}
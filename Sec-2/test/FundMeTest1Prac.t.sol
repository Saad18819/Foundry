// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe} from "../src/FundMe.sol";

contract FundMeTest is Test{

FundMe fundme;

uint256 num = 1;

function setUp() external{
fundme = new FundMe();
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
    assertEq(fundme.i_owner(),address(this));
}

function testgetVersion() public{
    assertEq(fundme.getVersion() , 4);
}

}
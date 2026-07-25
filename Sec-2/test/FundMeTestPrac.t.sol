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

}

// now we have 2 testing file so to test this u gotta put in terminal this
// "forge test --match-path test/YourPracticeFileName.t.sol"
// OR
// "forge test --mp test/YourPracticeFileName.t.sol"



/*
IMPORTANT LEARNING

No tests found in project! Forge looks for functions that start with `test`

Test wont work in while writing function name

 */

// after this go to script folder for next lesson thing
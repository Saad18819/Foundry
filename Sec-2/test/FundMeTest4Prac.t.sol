// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe2Prac} from "../src/FundMe2Prac.sol";

import {DeployFundMe3Prac} from "../script/DeployFundMe3Prac.s.sol";

contract FundMeTest4Prac is Test{

FundMe2Prac fundme;



uint256 constant dummyMoney = 10e18;
address dummyAdd = makeAddr("Saad");

uint256 num = 1;

function setUp() external{
DeployFundMe3Prac depFund = new DeployFundMe3Prac();
fundme = depFund.run();
vm.deal(dummyAdd , dummyMoney);
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

function testNotEnoughEth() public{
    vm.expectRevert();
    fundme.fund();
}

function testEnoughETH() external{
vm.prank(dummyAdd);
fundme.fund{value:dummyMoney}();
uint256 amntFunded = fundme. getAddToAmnt(dummyAdd);
assertEq(amntFunded , dummyMoney);
}
}



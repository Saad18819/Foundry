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

modifier funded(){
    vm.prank(dummyAdd);
    fundme.fund{value:dummyMoney}();
    _;
}

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

function testAdd() external funded{

address firstFunder = fundme.getAdd(0);

assertEq(firstFunder , dummyAdd);

}



function testonlyOwnercanWithdraw() external{
    vm.expectRevert();
    vm.prank(dummyAdd);
    fundme.withdraw();
}




function testWithdrawWithASingleFunder() external funded{

uint256 initialOwnerBalance = fundme.getOwner().balance;
uint256 initialContractBalance = address(fundme).balance;

vm.prank(fundme.getOwner());
fundme.withdraw();

uint256 finalOwnerBalance = fundme.getOwner().balance;
uint256 finalContractBalance = address(fundme).balance;

assertEq(finalContractBalance , 0);
assertEq(finalOwnerBalance , initialOwnerBalance +initialContractBalance);
}

function testWithdrawMultipleFunder() external funded{
    uint160 netfunders = 10;
    uint256 initialfunder =2;

    for(uint256 i = initialfunder ; i<netfunders;i++){
     hoax(address(uint160(i)),dummyMoney);
     fundme.fund{value:dummyMoney}();
    }

uint256 initialAmntOwner = fundme.getOwner().balance;
uint256 initialAmntContract = address(fundme).balance;

    vm.startPrank(fundme.getOwner());
    fundme.withdraw();
    vm.stopPrank();

    uint256 finalAmntOwner = fundme.getOwner().balance;
    uint256 finalAmntCOntract = address(fundme).balance;

    assertEq(initialAmntOwner + initialAmntContract , finalAmntOwner);


}
}



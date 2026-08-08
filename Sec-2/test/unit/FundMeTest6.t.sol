// SPDX-License-Identifier: MIT

// WE GONNA LEARN ABT GAS AND STORAGE OPTIMIZATION

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe4} from "../../src/FundMe4.sol";

// we are adding this
import {DeployFundMe5} from "../../script/DeployFundMe5.s.sol";


contract FundMeTest is Test{

FundMe4 fundme;

address USER = makeAddr("user");
uint256 constant SEND_VALUE = 0.1 ether;
uint256 constant STARTING_BALANCE = 10 ether;
uint256 constant GAS_PRICE = 1; // we set gas price 1 gwei here for the ease for calculation

uint256 num = 1;

modifier funded(){
    vm.prank(USER);
    fundme.fund{value:SEND_VALUE}();
    _;
}

function setUp() external{
DeployFundMe5 deployFundMe = new DeployFundMe5(); // this is just the blueprint of contract is made
fundme = deployFundMe.run(); // here u are actually calling it
vm.deal(USER,STARTING_BALANCE);
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
   // assertEq(fundme.i_owner(),msg.sender);
   assertEq(fundme.getOwner(),msg.sender);
}

function testgetVersion() public{
    assertEq(fundme.getVersion() , 4);
}


// using cheatcodes thing

function testRevertCheatCode() public{
    vm.expectRevert(); 
    uint256 cat =1 ; 
}

function testFundFailWithoutEnoughETH() public{
    
    vm.expectRevert();
fundme.fund();
}



function testFundUpdatesFundedDataStructure() public{
    
    vm.prank(USER); 
    
    fundme.fund{value:SEND_VALUE}();
    
    uint256 amountFunded = fundme.getAddressToAmountFunded(USER);  
    assertEq(amountFunded ,SEND_VALUE);
}


function testAddsFunderToArrayOffFunders() public funded{
   

    address funder = fundme.getFunder(0);
  
  
    assertEq(funder,USER);
  
}

function testOnlyOwnerCanWithdraw() public funded{
   
    vm.expectRevert(); 
    fundme.withdraw();

 
}





function testWithDrawWithASingleFunder() public funded{
  
    // ARRANGE
uint256 startingOwnerBalance = fundme.getOwner().balance;
uint256 startingFundMeBalance = address(fundme).balance;

    // ACT
    uint256 gasStart = gasleft(); // lets say 1000 gas hai....
    // gasleft() is a built-in Solidity function that returns the exact amount of gas remaining in the current transaction.
    vm.txGasPrice(GAS_PRICE);
    // vm.txGasPrice is a Forge-specific cheatcode that lets you simulate and set a specific tx.gasprice for your test environment.
    //By default, Foundry simulates tests with a gas price of 0. When your Solidity code checks the global environment variable tx.gasprice, it receives 0.

vm.prank(fundme.getOwner()); // cost: 200 gas
fundme.withdraw();


uint256 gasEnd = gasleft();// 800 gas remaining
uint256 gasUsed = (gasStart - gasEnd)* tx.gasprice;
// gas used will be in wei 
//tx.gasprice: Multiplies the raw gas units by the gas price (which was set to 1).

console.log(gasUsed);

    // ASSERT
    uint256 endingOwnerBalance = fundme.getOwner().balance;
    uint256 endingFundMeBalance = address(fundme).balance;
    assertEq(endingFundMeBalance , 0);
    assertEq(startingFundMeBalance + startingOwnerBalance , endingOwnerBalance);
}






function testWithdrawfromMultipleFunders() public funded{
   
   // ARRANGE
    uint160 numberOfFunders = 10;
    uint256 startingFunderIndex = 2;

 for(uint256 i=startingFunderIndex;i<numberOfFunders;i++){
    // vm.prank new address
    // vm.deal new address
    // address(0)
    hoax(address(uint160(i)),SEND_VALUE);
    fundme.fund{value:SEND_VALUE}();
    // fund the fundme
 }

uint256 startingOwnerBalance = fundme.getOwner().balance;
uint256 startinFundMebalance = address(fundme).balance;

// ACT
vm.startPrank(fundme.getOwner());
fundme.withdraw();
vm.stopPrank();


// ASSERT 
assert(address(fundme).balance == 0 );
assert(startinFundMebalance + startingOwnerBalance == fundme.getOwner().balance);


}













function testWithdrawfromMultipleFundersCheaper() public funded{
   
   // ARRANGE
    uint160 numberOfFunders = 10;
    uint256 startingFunderIndex = 2;

 for(uint256 i=startingFunderIndex;i<numberOfFunders;i++){
    // vm.prank new address
    // vm.deal new address
    // address(0)
    hoax(address(uint160(i)),SEND_VALUE);
    fundme.fund{value:SEND_VALUE}();
    // fund the fundme
 }

uint256 startingOwnerBalance = fundme.getOwner().balance;
uint256 startinFundMebalance = address(fundme).balance;

// ACT
vm.startPrank(fundme.getOwner());
fundme.cheaperWithdraw();
vm.stopPrank();


// ASSERT 
assert(address(fundme).balance == 0 );
assert(startinFundMebalance + startingOwnerBalance == fundme.getOwner().balance);


}
}



/*
EXPLANATION

i have copied this code from previous test file
to run this test u gotta write

forge test --match-path test/unit/FundMeTest6.t.sol

now onto integration folder ki file

*/
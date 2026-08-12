// SPDX-License-Identifier: MIT

// WE GONNA LEARN ABT GAS AND STORAGE OPTIMIZATION

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe3} from "../src/FundMe3.sol";

// we are adding this
import {DeployFundMe4} from "../script/DeployFundMe4.s.sol";


contract FundMeTest is Test{

FundMe3 fundme;

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
DeployFundMe4 deployFundMe = new DeployFundMe4(); // this is just the blueprint of contract is made
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
METHOD-1

in terminal write

1)forge snapshot --match-path test/FundMeTest5.t.sol --match-test testWithdrawfromMultipleFunders(function name)
it will create a new file called .gas-snapshot which will tell how much that function gonna take gas or gas cost

2)forge snapshot --match-path test/FundMeTest5.t.sol
will give gas used for each function

3)and then write a gas code

4)in terminal write this

forge test --match-path test/FundMeTest.t.sol --match-test testWithDrawWithASingleFunder

5)we will write more efficient code to make sure if there is any possibiilty of reducing the gas so 

6)go to FundMe3.sol write cheaper withdraw function
7)here write cheaper test function

8)forge snapshot --match-path test/FundMeTest5.t.sol --match-test testWithdrawfromMultipleFundersCheaper
9)just analyse the difference in gas bruhhh




LEARNING


if u go to website evm.codes it has all the gas needed for all operation so if u see for storage 

Any variable declared outside of any function (at the very top of your contract) is a state variable, which automatically gets stored in permanent Storage:
Since s_funders lives in storage, its length (s_funders.length) also lives in storage. Accessing it means reading a storage slot via the SLOAD opcode.


Reading and writing data permanently to the blockchain (storage) is one of the most expensive things you can do in Solidity. By moving temporary data into the contract's short-term memory, you can drastically reduce gas fees for your users.

Storage vs. Memory


Think of Storage like a permanent, heavy filing cabinet. Every time you open it to read or write data, you pay a massive fee.

Think of Memory like a temporary sticky note on your desk. Reading and writing here is incredibly cheap, but it gets thrown away when the function finishes.

Opcodes and Gas Fees
When you deploy a contract, it turns into "Bytecode" (a giant string of random letters and numbers like 0x6080...). The Ethereum Virtual Machine (EVM) breaks this down into basic machine instructions called Opcodes.

MLOAD and MSTORE: Instructions for reading/writing to Memory. They cost a minimum of 3 gas.

SLOAD and SSTORE: Instructions for reading/writing to Storage. They cost a minimum of 100 gas.

Reading from storage is at least 33 times more expensive than reading from memory.

In the original withdraw function, a for loop checks the total number of funders repeatedly:

If you have 1,000 funders, the contract walks over to the expensive filing cabinet (s_funders.length) 1,000 times. That means paying the 100-gas SLOAD fee 1,000 times just to check a number that isn't even changing.

The Solution: Caching in Memory
To fix this, you create a cheaperWithdraw function. You read the length from the expensive filing cabinet exactly once, write it on a cheap sticky note (local memory variable), and use the sticky note for the rest of the loop:



basically when u wrote in loop every time it was calling funders.length but when we assign the variable so the value is stored inside variable initially itself








immutable and constant are not stored so having style guide for that type of variable is highly important

     LIKE FOR IMMUTABLE i_saad  and for constant SAAD

     AND FOR STORAGE VARIABLES GENERALLY U WRITE s_variableName




*/
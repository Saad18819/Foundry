// SPDX-License-Identifier: MIT

// in this we will be testing FundMe.sol thing 


pragma solidity ^0.8.18;

// forge-std library has many standard packages that we can import to make running our test easier

import {Test, console} from "forge-std/Test.sol";
//Foundry automatically creates a rule behind the scenes that says: "Whenever the developer types forge-std/, automatically replace it with lib/forge-std/src/."



import {FundMe} from "../src/FundMe.sol";



contract FundMeTest is Test{


// first thing we wanna do is to test our fundme contract but before that we gotta deploy it ukk

uint256 number = 1;
FundMe fundMe;


function setUp() external{
    number = 2 ;

   // FundMe fundMe = new FundMe();
  // issue with above is global declaration nhi hora so we will ddo a global declaration

fundMe = new FundMe();
// by this u gonna deploy the contract fundme

}
// the function is made external when we its only meant to use internally but The Forge testing framework itself acts as the "external caller."

// before test " function setup"  always runs first


function testDemo() public{
   console.log(number);
    console.log("Hello! World");
assertEq(number , 2); // if true aa gaya then it tells us that setuo function pehle run hua
// assertEq() is a function used in testing to verify that two values are exactly equal to each other. It stands for "assert equal."
// assertEq(actualValue, expectedValue);
}

function testMinimumDollarIsFive() public{
    assertEq(fundMe.MINIMUM_USD(), 5e18);
    // basically variable ko hi call karne ka bhi yahi tarika hai
}

function testOwner() public{
    // assertEq(fundMe.i_owner(),msg.sender);
    // the above assert thing will fail becoz when we did forge test it will first run the setup function so that is where we are deploying the fundMesol.contract but here FundMeTest contract is clicking the deploy button so uska address store hua
    // and when we say here msg.sender it means foundry ka setup jo run karra uska address hai so it will give the different address and we can even check it with console.log
    // when we type address(this) it means it gives the address of contract jiske andar we are present

console.log(msg.sender);
console.log(fundMe.i_owner());
console.log(address(this));
assertEq(fundMe.i_owner(),address(this));
}

}


/*
important learning 

When you type forge test, the very first thing Forge does before it even looks at your test files is compile your entire project—which includes everything inside your src/ folder.

so by mistake if we have error in files inside src then it will give compilation error 

ANOTHER METHOD for testing and debugging IS CONSOLE LOG

The console library comes packed with Test.sol that we imported so we need to import "console"
after writing console log thing then in command write this "forge test -vv" v specifies the visisbilty of logging in


SOME FORGE TEST THINGS TO REMEMBER (-no of v tells how much details you want to see when ur test run...they are verbosity level)

forge test (No v) — Show only if tests pass or fail.

forge test -v — Show details for failed tests only.

forge test -vv — Show all console.log outputs (regardless of whether the test passed or failed). This is why you used it.

forge test -vvv — Show execution traces for failed tests.

forge test -vvvv — Show full execution traces for all tests, showing exactly how every single EVM opcode and function call moved.

forge test -vvvvv — Show setup traces as well (everything including the setUp function execution).




another important thing



est functions (test...) actually can be marked external, and it works perfectly.

However, we usually mark them public instead of external for two specific reasons:


1. public can do everything external can do
In Solidity, a public function can be called by outside users (like the Foundry testing framework) and it can also be called internally by your own contract. Since Foundry looks at your test contract from the outside, it can see and trigger both public and external functions with no issues.


2.external functions can only be called from the outside (by other users or other smart contracts). The contract cannot call its own external function internally.

public functions are completely open. They can be called from the outside and they can also be called internally by the contract itself.


 */
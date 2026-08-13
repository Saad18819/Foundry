// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

// in this basically we will be testing getVersion function inside Fundme.sol basicall what version number is there
// basically it gives the version of smart contract that calculates and post the off chain data it gives the integer only

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
   // for above thing we ran and generally version 4 rehta most of the time
   // forge test --mp test/FundMeTest1.t.sol --mt testgetVersion -vvv
   // we used 3 v's to get the actuall error we getting

   
}



// to run specifc function test use this in command terminal
// "forge test --mp test/YourPracticeFileName.t.sol --mt functionName"
// here mt means match-test we can use anything similarly mp means match-path

// with above terminal cmnd we can add -multiple[v] to get more info abt test

/*

when we wrote this in testgetversion  "assertEq(fundme.getVersion() , 4);"
and then in terminal
forge test --mp test/FundMeTest1.t.sol --mt testgetVersion -vvv


this is the error we got

Ran 1 test for test/FundMeTest1.t.sol:FundMeTest
[FAIL: call to non-contract address 0x694AA1769357215DE4FAC081bf1f309aDC325306] testgetVersion() (gas: 8054)
Traces:
  [8054] FundMeTest::testgetVersion()
    ├─ [2980] FundMe::getVersion() [staticcall]
    │   ├─ [0] 0x694AA1769357215DE4FAC081bf1f309aDC325306::version() [staticcall]
    │   │   └─ ← [Stop]
    │   └─ ← [Revert] call to non-contract address 0x694AA1769357215DE4FAC081bf1f309aDC325306
    └─ ← [Revert] call to non-contract address 0x694AA1769357215DE4FAC081bf1f309aDC325306


    this happened coz jitne bhi foundry test hai voh run hote local(runs on machine doesnt connect to internet) empty(it starts from block no 0 with zero deployed contracts) anvil blockchain pe by default
    the error means

    [Sepolia Network]
0x694A...306  --->  [ Chainlink Price Feed Code ]

[Your Local Anvil]
0x694A...306  --->  [ EMPTY / Nothing here! ]

our computer tries to find it in anvil blockchain and vaha pe kuch exist hi nhi karta so it reverts back



NOW SOLUTION

what we can do to work with addresses outside our system so there are 4 types of test we can try out


1) Unit tests: Focus on isolating and testing individual smart contract functions or functionalities.
bacially where we test a very specific part of our code like for example testing a single function get version typa shit

2) Integration tests: Verify how a smart contract interacts with other contracts or external systems.


3) Forking tests: Forking refers to creating a copy of a blockchain state at a specific point in time. This copy, called a fork, is then used to run tests in a simulated environment.
in forking test basically the address we have put in vaha pe jo bhi exist we make copy of it and run that on anvil blockchain

4) Staging tests: Execute tests against a deployed smart contract on a staging environment before mainnet deployment.



SO THE SOLUTION WHICH WE GONNA USE IS FORKING

1)Go to alchemy and grab an API KEY
2)make .env file and store it
3)and in gitignore write .env below #Dotenv file text
4)run "source .env" in cmnd terminal
5)run echo $nameOfURL
6)In terminal write "forge test --mp test/FundMeTest1.t.sol --mt testgetVersion -vvv --fork-url $NameOfURL(in .env file)"
"forge test --mp test/FundMeTest1.t.sol --mt testgetVersion -vvvvv --fork-url $SEPOLIA_RPC_URL"

this is how we access sepolia env variable and what will happen is anvil will actually get spun up but it will take a copy of sepolia RPC URL and it will spin up the anvil but it will simulate all of our transaction as if they are actually running on the sepolia chain
so it will pretend to read it from the sepolia chain



THE ISSUE WITH FORKING IS U GONNA MAKE TONS OF API CALLS WHICH WILL RUN UP UR BILL


ALSOOOOOO




TO GET OUR TEST COVERAGE WE WILL RUN THIS IN COMMMAND
"forge coverage --fork-url $SEPOLIA_RPC_URL"


You are asking Foundry to run every test in your project on a Sepolia-forked Anvil environment and calculate how much of your Solidity code is actually executed (tested) during those test runs.



% Lines
What it means: The percentage of code lines that were executed at least once during the tests.

Your Result (src/FundMe.sol: 22.73%): Out of 22 lines of executable code in FundMe.sol, your current test suite only touched 5 lines. The remaining 17 lines were never triggered during testing.


% Statements
What it means: Individual instructions/statements executed.

Why it differs from Lines: A single line of code can contain multiple statements (e.g., uint256 x = 1; uint256 y = 2;). This measures individual operations rather than line numbers.




% Branches
What it means: Coverage of conditional execution paths (like if / else, require(), or loops).

Your Result (0.00% (0/5)): You have 5 decision points (e.g., require(msg.value >= MINIMUM_USD), if (msg.sender != i_owner)).

Why it's 0%: You haven't written tests that specifically test both the true condition (valid transaction) and the false condition (reverting transaction) for those statements yet.




% Funcs
What it means: The percentage of total functions in that contract that were called.

Your Result (28.57% (2/7)): FundMe.sol has 7 functions, and your tests currently invoke 2 of them (one of which is likely getVersion()!).







NOW MOVE TO FundMe1.sol

 */





}
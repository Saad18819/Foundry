// SPDX-License-Identifier: MIT

// WE GONNA LEARN ABT FOUNDRY TEST CHEATCODES

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";

import {FundMe2} from "../src/FundMe2.sol";

// we are adding this
import {DeployFundMe3} from "../script/DeployFundMe3.s.sol";


contract FundMeTest is Test{

FundMe2 fundme;

address USER = makeAddr("user");
uint256 constant SEND_VALUE = 0.1 ether;// although we wrote it in decimal but compiler will convert into e type shit 
uint256 constant STARTING_BALANCE = 10 ether;

uint256 num = 1;

modifier funded(){
    vm.prank(USER);
    fundme.fund{value:SEND_VALUE}();
    _;
}

function setUp() external{
DeployFundMe3 deployFundMe = new DeployFundMe3(); // this is just the blueprint of contract is made
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
    vm.expectRevert(); // tells Foundry: "The VERY NEXT call must fail (revert). If it reverts, pass the test. If it succeeds, fail the test."
    uint256 cat =1 ; //so basically test will fail or revert coz ye line fail nhi hui coz isme kuch issue nhi tha

    // so basically if we want this test to pass so we goota write something after vm.expectRevert that line fail ho jaye which we did in next function

}

function testFundFailWithoutEnoughETH() public{
    
    vm.expectRevert();
fundme.fund(); // it sends 0 value so ab ye line fail hoyegi coz of not enough fund isiliye test pass hoyega
// fundme.fund() without attaching ETH passes 0 value. The require(..., "You need to spend more ETH!") guard inside FundMe2 fails and reverts. Since vm.expectRevert() expected a revert on that line, Foundry marks the test as PASSED.
}


// ab now basically u are updating value here so we gotta check in fund vala function ki array me value update hori kya so we go back to FundMe2.sol
function testFundUpdatesFundedDataStructure() public{
    
    vm.prank(USER); // the next TX will be sent by user and inside vm.prank u have to pass address only
    
    fundme.fund{value:SEND_VALUE}();
    // it doesnt mean we are kinda adding paramter here it means basically the value we are putting is to attach it to msg.value
    // you only attach {value: ...} when the function expects ETH via msg.value (i.e. payable functions). You do not attach {value: ...} just because a function checks msg.sender.
    uint256 amountFunded = fundme.getAddressToAmountFunded(USER);  // its too confusing whether it should be address(this) or msg.sender so we have another cheat code for this prank cheat code
    assertEq(amountFunded ,SEND_VALUE);
}


function testAddsFunderToArrayOffFunders() public funded{
   // vm.prank(USER);
    // vm.prank(USER); $\rightarrow$ Instructs Foundry that the very next transaction will be initiated by USER instead of the test contract (address(this)).
    // fundme.fund{value:SEND_VALUE}();
    //fundme.fund{value: SEND_VALUE}(); $\rightarrow$ USER calls the fund() function in FundMe2.sol and attaches 0.1 ether (SEND_VALUE). Inside FundMe2.sol, this function pushes msg.sender (which is USER) into the s_funders array at index 0

    address funder = fundme.getFunder(0);
    // address funder = fundme.getFunder(0); $\rightarrow$ Calls the getter function getFunder(0) to read who is stored at index 0 of the funders array.
  
    assertEq(funder,USER);
   //  assertEq(funder, USER); $\rightarrow$ Verifies that the address returned from index 0 matches USER. If it matches, the test passes.

}

function testOnlyOwnerCanWithdraw() public funded{
    // vm.prank(USER);
    // fundme.fund{value:SEND_VALUE}();

    vm.expectRevert(); // basically it tells to revert the next line but if the next line is vm. stuff then it ignores it
    vm.prank(USER);
    fundme.withdraw();

 // fundme.withdraw(); $\rightarrow$ USER tries to withdraw the contract's funds. But inside FundMe2.sol, there is a modifier or check requiring msg.sender == i_owner. Since USER is not the owner (the owner is msg.sender from DeployFundMe3), withdraw() reverts.   
}


// NEXT 2 FUNCTIONS HAVE USED THE AAA METHOD(ARRANGE-ACT-ASSERT)



function testWithDrawWithASingleFunder() public funded{
  
    // ARRANGE
uint256 startingOwnerBalance = fundme.getOwner().balance;
uint256 startingFundMeBalance = address(fundme).balance;

    // ACT
vm.prank(fundme.getOwner());
fundme.withdraw();

    // ASSERT
    uint256 endingOwnerBalance = fundme.getOwner().balance;
    uint256 endingFundMeBalance = address(fundme).balance;
    assertEq(endingFundMeBalance , 0);
    assertEq(startingFundMeBalance + startingOwnerBalance , endingOwnerBalance);
}
/*
EXPLANATION

This function tests the scenario where only one person has sent money to the contract, and then the owner withdraws all of it. We want to prove that:

The contract balance drops to 0 ETH.

All that money is transferred into the owner's wallet.




Phase 1: ARRANGE (Setting up initial data)

We take a "snapshot" of the bank balances before the withdrawal happens:

We record how much ETH the contract owner has in their wallet (startingOwnerBalance).

We record how much ETH is currently inside the FundMe2 contract (startingFundMeBalance, which is 0.1 ETH).





Phase 2: ACT (Executing the operation)

vm.prank(...) tells Foundry: "Pretend the owner is sending the next transaction."

fundme.withdraw() triggers the withdrawal function inside FundMe2.sol.





Phase 3: ASSERT (Verifying the math)


We check if the final balances make mathematical sense:

endingFundMeBalance must be 0 (all money was pulled out).

The owner's new balance (endingOwnerBalance) must equal what they started with PLUS what was inside the contract.












 */





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

/*
EXPLANATION

Phase 1: ARRANGE (Generating multiple fake users and funding)

Why uint160? Ethereum addresses are 160 bits (20 bytes) long. In Solidity, to convert a number like 2 or 3 into a valid Ethereum address, it must be cast to uint160 first.
when u write for example
uint256 number = 10
address saad = address(uint160(number));
so basically address kabhi bhi 160 bits me rehta so we converte the number into uint160 first and then ab just like if u write float(25) so it will give 25.00 similarly addres(25) it will convert the 25 in hex value  of it with address type 0x.... and store in saad variable its basically typecasting only

Why start index at 2?

Index 0 is often reserved for address(0) (null address).

Index 1 is already used by USER in the funded modifier. So we start generating new addresses from 2 up to 9.





Inside this for loop, we generate 8 new fake users (address(2), address(3), ... address(9)):


hoax(address, value): 
This is a combination cheatcode. 
It does two things at once:
vm.deal(address, SEND_VALUE) => Gives the fake address 0.1 ETH.
vm.prank(address) => Sets msg.sender to that fake address for the next call.fundme.fund{value: SEND_VALUE}(): 
The fake address sends 0.1 ETH into FundMe2.
At the end of this loop, FundMe2 holds funds from 9 different users (1 from funded modifier + 8 from loop = 0.9 ETH total).





Phase 2: ACT (Withdrawing with startPrank)

Why vm.startPrank instead of vm.prank?

vm.prank only applies to the very next transaction.

vm.startPrank keeps msg.sender set as fundme.getOwner() for all subsequent transactions until you explicitly call vm.stopPrank().

If your withdraw() function makes multiple calls or state changes under the hood, startPrank ensures the owner context persists throughout.

You only need startPrank when a single user has to execute multiple transactions in a row: here just vm.prank would have worked as well properly 


Phase 3: ASSERT (Verifying final balances)

ssert(...): Standard Solidity assertion checking if the condition evaluates to true.

It verifies that the FundMe2 contract balance was completely drained to 0, and the combined total was added to the owner's balance.










 */




}



/*

also note that setup runs first everytime for each test function lik for example setup will run and then function test1 and then again setup and then test2 like that




FOUNDRY TEST CHEATCODES EXPLANATION

1)search foundry on google and then open their website and go to cheatcode section and it will have many cheat codes wtih them
2)also make  FundMe2.sol and DeployFundMe3.s.sol
3)after writing this full code in terminal write
4)forge test --mp test/FundMeTest4.t.sol
5)forge coverage --match-test test/FundMeTest4.t.sol



LOGIC BEHIND vm.prank() and vm.deal()

When you write tests in Foundry, your test contract is the one executing all the lines of code.

By default:

The caller (msg.sender) inside your functions is the test contract's address (address(this)).

Any new address you generate (like address USER = makeAddr("user")) is completely broke and has 0 ETH balance.

Foundry gives you vm.prank and vm.deal so you can manipulate the blockchain environment to simulate real users.




1. vm.deal — Giving ETH to an address

What it does:
Sets the ETH balance of any specified address to a number you choose. Think of it as "cheat-code minting" ETH into an account.

When to use it:
Whenever you create a fake user address (makeAddr("user")) that needs to send ETH or pay for transactions.

Whenever you need to test scenarios where an account holds a specific ETH balance.




2. vm.prank — Changing msg.sender


What it does:
Forces the very next transaction to be sent from the address you pass into vm.prank(...). It tricks the target contract into thinking that specific address called it.





3. address USER = makeAddr("user");

Yes, USER is a variable of type address that stores the generated address.

The string "user" inside makeAddr("user") is a seed label used by Foundry to calculate and tag that address.
Foundry takes the string "user", hashes it, and derives a unique 20-byte Ethereum address from that string.

makeAddr("user") will always produce the exact same Ethereum address every time you run your test suite.

makeAddr("alice") will produce a completely different address.

ahh so we can write anything inside it rytt just based on what we write it will calculate mathemcatically some address




LETS TALK ABT IMPORTANT SOLIDITY TOOL CHISEL

Chisel is one of the 4 components of Foundry alongside forge, cast and anvil. It's a tool that allows users to quickly test the behavior of Solidity code on a local (anvil) or forked network.

Usually, when you want to test a small Solidity code snippet you go to Remix. But why do that when you have what you need right in the terminal of your Foundry project.

cmnd for terminals

STEP 1:chisel
STEP 2: !help
STEP 3 : start writing solidity code

for example this is what i did

➜ uint256 number = 10;
➜ address saad = address(uint160(number))
➜ 
➜ saad
Type: address
└ Data: 0x000000000000000000000000000000000000000A
➜ number
Type: uint256
├ Hex: 0xa
├ Hex (full word): 0x000000000000000000000000000000000000000000000000000000000000000a
└ Decimal: 10

















 */
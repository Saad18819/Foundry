// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe4} from "../../src/FundMe4.sol";
import {DeployFundMe5} from "../../script/DeployFundMe5.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    // 1. Declare state variables
    FundMe4 fundMe;

    address USER = makeAddr("user");
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        // 2. Fix deployment variable and assignment
        DeployFundMe5 deploy = new DeployFundMe5();
        fundMe = deploy.run(); 

        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteraction() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        // 3. Fix capitalization (fundMe)
        assert(address(fundMe).balance == 0);
    }
}

/*
forge test --match-path test/integration/InteractionTest.t.sol --match-test testUserCanFundInteraction

OR

forge test --match-path test/integration/InteractionTest.t.sol --match-test testUserCanFundInteraction -vvvv


PROPER EXPLANATION

This integration test checks one big thing: "Can a user fund our contract using our script, and then can the owner withdraw that money using our withdrawal script?"

This test file proves that your deployment, funding script, and withdrawal script all work together smoothly in an end-to-end simulation.


just remember interaction.s.sol file is the actula thing and to test that we write integration test 


Think of the full development cycle like this:

Unit Tests (FundMeTest.t.sol): You test individual functions in isolation. "Does fund() increase balance? Does withdraw() reset the mapping?"

Integration Tests (InteractionsTest.t.sol): You test your entire ecosystem working together. "Does my Deploy Script deploy properly, then my Interaction Script fund it, and then my Withdraw Script drain it cleanly without breaking?"

Live Scripts (Interactions.s.sol / DeployFundMe.s.sol): Once the integration test passes with green checks, you finally run your scripts on the real network (Sepolia/Mainnet) with total confidence that nothing will break.



done with it now next lesson is Makefile go that file and see





 */
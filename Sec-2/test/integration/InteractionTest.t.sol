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







 */
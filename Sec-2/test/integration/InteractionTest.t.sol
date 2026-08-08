// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test , console} from "forge-std/Test.sol";
import {FundMe4} from "../../src/FundMe4.sol";
import {DeployFundMe5} from "../../script/DeployFundMe5.s.sol";
import {FundFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test{

    function setUp() external{
        DeployFundMe5 deploy = new DeployFundMe5();
        fundme = deployFundMe.run(); 
        vm.deal(USER,STARTING_BALANCE);
    }

    function testUserCanFundInteraction() public{
    FundFundMe fundFundMe = new FundFundMe();
    fundFundMe.fundFundMe(address(fundMe));

    address funder = fundMe.getFunder(0);
    assertEq(funder , USER);
    }
}


/*
forge test --match-path test/integration/InteractionTest.t.sol --match-test testUserCanFundInteraction


11:29


 */
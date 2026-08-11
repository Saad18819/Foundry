// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployFundMe5} from "../../script/DeployFundMe5.s.sol";
import {FundMe4} from "../../src/FundMe4.sol";
import {fundFundMe , withdrawFundMe} from "../../script/interactionsPrac.s.sol";

contract Interactions is Test{
    FundMe4 fundingme;

    address USER = makeAddr("Saad");
    uint256 constant STARTING_BALANCE = 10 ether;

    function setup() external{
        DeployFundMe5 deployscript = new DeployFundMe5();
        deployed = deployscript.run();
        vm.deal(USER , STARTING_BALANCE);
    }

    function testInteractions() external{
        fundFundMe abc = new fundFundMe();
        abc.funding(address(fundingme));

        withdrawFundMe xyz = new withdrawFundMe();
        xyz.withdrawing(address(fundingme));


        assertEq(address(fundingme).balance , 0);
    }
}
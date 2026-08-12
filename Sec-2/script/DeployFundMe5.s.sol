// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe4} from "../src/FundMe4.sol";
import {HelperConfigPrac} from "./HelperConfigPrac.s.sol";

contract DeployFundMe5 is Script{



function run() external returns(FundMe4){

HelperConfigPrac helperContract = new HelperConfigPrac();
address ethUsdPrice = helperContract.priceFeedStore();

    vm.startBroadcast();
    FundMe4 fundMe = new FundMe4(ethUsdPrice);
    vm.stopBroadcast();
    return fundMe;
}
}


/*
PROPER EXPLANATION ABT THESE INTEGRATION TEST

so basically if we wanna test this architecture first we will write the command in terminal to fund out contract and then withdraw logic to test if its workng or not since yaha pe code is small toh it was fine but if code is way too  then what u gonna do

so basically we have made a no of files with the usage of each of them

1)test folder ke andar unit folder where test file we made and its the common test file and
Its use is same as other test file basucally it test each function in isolation properly

2)test folder ke andar integration file uske ke andar integrationTest file
this file is the core file basically this file actualy test the real world workflow (like does our deployment script + funding script + withdrawal script work together seamlessly end to end or not)

3)in script folder make interactions.s.sol file 
Think of Interactions.s.sol as a remote control with pre-programmed buttons for your smart contract.
ou write the code to call fund() or withdraw() once in Solidity inside Interactions.s.sol. Now, whenever you want to trigger those actions, you just run that one script.

1. To trigger the Funding action:
forge script script/Interactions.s.sol:FundFundMe --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast

2. To trigger the Withdrawal action:
forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast



4)DEVOPS EXPLANATION

The Problem Without DevOps Tools
Without foundry-devops, every single time you change your Solidity code and deploy it to Anvil or Sepolia, Ethereum gives your contract a brand new address (e.g., 0x111... becomes 0x222...).

To test or run your interaction script (Interactions.s.sol), you would have to:

Look at your terminal screen after deploying.

Highlight and copy the new address (0x222...).

Open Interactions.s.sol in your code editor.

Paste that new address into your code manually.

Save the file and finally run your script.

If you deploy 20 times while testing, you have to manually copy and paste addresses 20 times.

The Solution With DevOps Tools
The DevOps tool is an automatic address finder.

It tells your computer:

"Hey, don't ask me for the address! Just go look into the broadcast folder, find the absolute last contract we deployed on this network, grab its address, and use that automatically."

Now, when you run Interactions.s.sol:

You don't copy-paste anything.

DevOpsTools.get_most_recent_deployment() automatically fetches 0x222... for you instantly.




Real-World Analogy


FundMe4.sol = The Vending Machine (The smart contract holding money and logic).

DeployFundMe5.s.sol = The Delivery Truck (Puts the vending machine on the street/blockchain).

Interactions.s.sol = The Buttons on the Machine (A preset script for "Insert $10" or "Press Refund").

InteractionsTest.t.sol = The Quality Control Inspector (Presses those buttons to make sure the machine actually accepts money and gives a refund properly).






Here is the natural workflow you always follow:

Write your Core Contract (src/FundMe4.sol)

Write your Deployment Script (script/DeployFundMe.s.sol)

Write your Interaction Script (script/Interactions.s.sol) ──▶ This builds the remote control buttons for funding and withdrawing.

Write your Integration Test (test/integration/InteractionsTest.t.sol) ──▶ This imports and runs Interactions.s.sol to verify everything works together.

 */
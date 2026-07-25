// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol"; 

import {SimpleStorage} from "../src/SimpleStorage.sol";

contract DeploySimpleStorage is Script {
    function run() external returns (SimpleStorage) {
        vm.startBroadcast();
        // vm is a special keyword in the forge standard library (forge-std) and its kinda a cheat code that allows us to interact with the blockchain in a way that we normally wouldnt be able to do in a normal solidity contract
        // it says to forge "Hey, I want to start broadcasting my transactions to the blockchain now, so please start listening to me and record all the transactions that I am going to send from now on after this line of code and u shld actually send to the RPC url that i have specified in the terminal when i run the script"

        SimpleStorage simpleStorage = new SimpleStorage();

        vm.stopBroadcast();
        // we use above code when we are done broadcasting our transactions to the blockchain and we want forge to stop listening to us and stop recording all the transactions that we are going to send from now on after this line of code and u shld actually stop sending to the RPC url that i have specified in the terminal when i run the script

        return simpleStorage;
    }
}

/*

any transaction that we actually want to send we need to put in vm.startBroadcast() and vm.stopBroadcast() so that forge knows that we actually want to send this transaction to the blockchain and not just simulate it








1. Does the code create a blueprint or deploy it?
It deploys it.

The line SimpleStorage simpleStorage = new SimpleStorage(); is the execution command.

Because it is inside the startBroadcast() block, Forge takes the compiled blueprint (the bytecode of SimpleStorage) and builds a real contract creation transaction.

It signs that transaction using the private key you provide in your terminal and sends it to the Anvil RPC URL.

Once mined, a brand new instance of your contract officially exists at a specific address on your local blockchain. The variable simpleStorage holds that new live address.










2. Why are we using the script/ folder for this?
Even though this is just a few lines of code, putting it in a script file gives you three major superpowers that command-line deployment (forge create) cannot give you:

It generates a "Broadcast Ledger": When you run a script, Foundry automatically creates a JSON file inside a folder named broadcast/. This file records the exact address your contract was deployed to, how much gas it used, and the transaction hash. If you deploy via the command line alone, that address disappears from your screen, and you have to dig through console logs to find it.

Environments are hot-swappable: You can use this exact same file to deploy to Anvil today, a Sepolia testnet tomorrow, and Mainnet next week. You don't change a single line of code; you just change the --rpc-url flag in your terminal command.

Scalability: Right now you are only deploying one contract. But what happens when SimpleStorage needs to talk to a PriceFeed contract? In this script, you can just add PriceFeed pf = new PriceFeed(); right above it and pass pf into SimpleStorage. Managing multi-contract deployments from a pure terminal command line quickly becomes an unreadable nightmare.







 */

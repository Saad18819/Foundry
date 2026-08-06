// SPDX-License-Identifier:MIT



// deploy mocks when we are on local anvil
// keep track of contracts address across different chain basically can work with any chain we want


pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";

// is Script coz we gonna use vm keyword
contract HelperConfig is Script{
// if we are on a local anvil we deploy mocks
// otherwise grab the exisiting address from the live network

struct NetworkConfig{
    address priceFeed; // ETH/USD price feed address
}

/*
Why a struct? Today, you only need priceFeed. But tomorrow, if you need a VRF Coordinator address, a DEX Router address, or a LINK token address, you can just add them into this struct without changing your whole setup.


 */

uint8 public constant DECIMALS = 8;
int256 public constant INITIAL_PRICE = 2000e8;

NetworkConfig public activeNetworkConfig;

constructor(){
    if(block.chainid == 11155111){
        activeNetworkConfig = getSepoliaEthConfig();
        // block.chainid  refers to chains current ID basically every network has their own chainID
    } else if(block.chainid == 1) {
        activeNetworkConfig = getMainnetEthConfig();
    }else{
        activeNetworkConfig = getAnvilEthConfig();
    }
}
/*
When Foundry runs this script, block.chainid automatically reflects the chain provided by your terminal command or RPC URL (--rpc-url). The constructor immediately runs and sets activeNetworkConfig to the right network.


 */

// Why memory? In Solidity, custom structs are complex types. When a function creates or returns a struct, you must explicitly declare its data location (memory means temporary memory for the duration of the function call).
//Why pure? These functions don't read from or write to contract state storage (activeNetworkConfig). They simply construct a temporary struct in memory and hand it back, so pure saves gas and keeps the function read-only.
function getSepoliaEthConfig() public pure returns(NetworkConfig memory) { // have to use memoruy keyword coz its the special object
    // all we need is a price feed address
    NetworkConfig memory sepoliaConfig = NetworkConfig({priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
    return sepoliaConfig;
}

/*
You're completely right about how memory works: it disappears as soon as the function finishes executing.

So why do we write returns (NetworkConfig memory)? Where does the data go if memory disappears?

The Secret: Data is Copied, Not Destroyed
Think of memory like a piece of scratch paper.(scrathc paper means just u a kind rough paper u write down for that instant and lster on throw it away)

Inside getSepoliaEthConfig(), Solidity grabs a fresh sheet of scratch paper (memory) and writes down the Sepolia address on it.

The function reaches return sepoliaConfig;.

Here's the trick: Solidity takes the value written on that scratch paper, hands a copy of it to whoever called the function, and then throws the scratch paper in the trash.

The memory where sepoliaConfig lived is gone, but the result was passed along to the next step in your code.






 */

function getMainnetEthConfig() public pure returns(NetworkConfig memory){
    NetworkConfig memory ethConfig = NetworkConfig({priceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
return ethConfig;
}

function getAnvilEthConfig() public returns(NetworkConfig memory){
    // all we need is a price feed address
    // deploy the mocks (a mock contract is basically a fake contract...its like a contract which we own and can control etc)
    // return the mock address


if(activeNetworkConfig.priceFeed != address(0)){
    return activeNetworkConfig;
}

/*



In Solidity:

address(0) (0x0000000000000000000000000000000000000000) is the default uninitialized value for any address variable.

When your contract first boots up, activeNetworkConfig.priceFeed starts as address(0).

Here is the step-by-step execution flow on Anvil:

First time getAnvilEthConfig() is called:

Solidity checks: Is activeNetworkConfig.priceFeed not equal to address(0)?

No (it is still address(0) because no mock has been deployed yet).

It skips the if block, runs vm.startBroadcast(), deploys a fresh MockV3Aggregator, and sets activeNetworkConfig.priceFeed = address(mockPriceFeed).


Second time getAnvilEthConfig() is called (e.g., in a multi-step script or test setup):

Solidity checks: Is activeNetworkConfig.priceFeed not equal to address(0)?

Yes! It already holds the address of the mock we deployed in step 1 (0x5FbDB2315678afecb367f032d93F642f64180aa3).

The if block triggers, returning the already-existing mock address immediately.



 */

vm.startBroadcast(); // function cant be pure here
// MockV3Aggregator mockPriceFeed = new MockV3aggregator(8,2000e8);
MockV3Aggregator mockPriceFeed = new MockV3Aggregator(DECIMALS,INITIAL_PRICE);
/*
Magic numbers refer to literal values directly included in the code without any explanation or context. 
These numbers can appear anywhere in the code, but they're particularly problematic when used in calculations or comparisons.
 By using magic numbers you ensure your smart contract suffers from Reduced Readability, Increased Maintenance Difficulty and Debugging Challenges.
  You also make your work extremely prone to error, imagine you used the same magic number in 10 places and you want to change it. 
  Will you remember all the 9 places or will you change it only in 8?


so we bsically define the variables and put that in param


 */

vm.stopBroadcast();

NetworkConfig memory anvilConfig = NetworkConfig({priceFeed: address(mockPriceFeed)});

return anvilConfig;





}

}
/*

// to deploy our own price feed we need a price feed contract
// in test make a new folder mocks and this is where we are going to put all of our contracts that we need to do testing
// create a new file MockV3Aggregator.sol and check it out
//first import the file here
// new MockV3aggregator(8,2000e8); basically bracket ke andar isiliye likha coz contructor parameter dalna padhta

PROPER EXPLANATION 

What is a Mock?
When running tests locally on Anvil, you don't have access to real Chainlink nodes fetching live stock/crypto data. A Mock is a lightweight "fake" contract that impersonates Chainlink's AggregatorV3Interface. It holds dummy data (e.g., setting 1 ETH = $2000) so your contract can talk to it during testing as if it were the real thing.

Yes, a Fork does a similar job by bringing external contracts into your local environment, BUT Mocks and Forks serve completely different purposes in real-world testing.


fork me basically u pull contracts directly from sepolia or mainnet
in mock u actully make a dummy contract directly on anvil. in mocks basically we have the control to change the features inside contract



A Fork COPIES the real deployed code and storage off the actual live chain (like Sepolia or Mainnet) into your local Anvil memory using your internet connection.

A Mock BUILDS A BRAND NEW FAKE CONTRACT from scratch directly on Anvil using your local computer's compiler—no internet or live chain involved.


1. What happens when you run a Fork?
When you pass --fork-url <RPC_URL>, Anvil turns into a mirror of Sepolia or Mainnet:

Anvil sends an API request to Alchemy/Infura: "Hey, fetch the bytecode and storage at 0x694AA176... on Sepolia."

Anvil stores that exact contract copy locally in RAM.

Result: You interact with the exact, real Chainlink smart contract that exists on Sepolia, populated with real-time live prices.



What happens when you use a Mock?
When you execute MockV3Aggregator mock = new MockV3Aggregator(8, 2000e8) in your HelperConfig.s.sol:

You are not connecting to Sepolia or downloading anything.

You are compiling a simple mock file (MockV3Aggregator.sol) that implements latestRoundData() to return whatever static number you passed in (e.g., $2000).

Result: You have a brand new, lightweight fake contract that mimics Chainlink's function signatures, completely offline.



Why vm.startBroadcast() here?
getAnvilEthConfig() isn't just fetching an address—it is deploying a brand-new contract (new MockV3Aggregator) to your local Anvil chain.

Deploying a contract is a transaction. Therefore, it requires vm.startBroadcast() so Foundry knows to sign and execute that deployment on Anvil.

That's why this function cannot be pure or view.





Terminal Command: forge script script/DeployFundMe.s.sol --rpc-url sepolia
                                │
                                ▼
                       1. Runs HelperConfig
                                │
               ┌────────────────┴────────────────┐
               ▼                                 ▼
   Running on Sepolia?               Running on Anvil?
               │                                 │
   Grabs hardcoded address            Deploys MockV3Aggregator
      (0x694AA176...)               Returns fresh Mock address
               │                                 │
               └────────────────┬────────────────┘
                                │
                                ▼
         2. Passes priceFeed address into FundMe constructor
                                │
                                ▼
                     3. FundMe is Deployed!




                     



Whenever you are testing on a raw local Anvil chain, deploying mock contracts is standard practice.

Here is why it's the default workflow:

The "Empty Room" Concept
When you start a fresh Anvil node (anvil), it boots up as a completely blank, isolated blockchain. It only has two things out of the box:

10 default accounts funded with fake 10,000 ETH each.

An empty state database.

There are no Chainlink price feeds, no Uniswap routers, no ERC-20 tokens, and no protocols. If your smart contract relies on any external contract, those addresses simply do not exist on Anvil unless you put them there.







 */











/*
EXPLANATION

The problem is when u hardcode the address then u cant run that thing on other network soooo we need flexibility that why in helperconfig it checks which network u are runnin it grabs the price feed

see the thing is its simple basically what actually happened is instead of harcoding address in helperconfig u write all the types of chainid u wanna run 
so basically when u put the cmnd in terminal based on RPC url it ask what kind of chain ID it is and based on that it runs if-else thing
HelperConfig hands that address back to your deployment script (DeployFundMe), which uses it to deploy your contract.

*/
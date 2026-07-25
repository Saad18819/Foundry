// SPDX-License-Identifier:MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe1} from "../src/FundMe1.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe2 is Script{

function run() external returns(FundMe1){
    
// anything u write before startBroadcast will not require gas and wont be a real transaction its just going to simulate the thing in simulated environment
// anything after the startBroadcast its going to be a real transaction
// You don't want HelperConfig to be a permanent, deployed smart contract living on Sepolia. You only need it as an off-chain "lookup engine" during the deployment process. Instantiating it off-chain before broadcasting keeps your real-world deployment footprint clean.

HelperConfig helperConfig = new HelperConfig();
// we wrote it here coz we dont wanna spend gas on it

address ethUsdPriceFeed = helperConfig.activeNetworkConfig();
// helperConfig.activeNetworkConfig().priceFeed ye nhi chalega coz .priceFeed wont make sense jab pata hai in struct we only have one field
// ab above me helper vale struct me jyaad a cheez rehti toh u gotta write this way (address ethblahblah , , , ) = like this


// You do not want HelperConfig itself to be a permanent, gas-paying contract on the Sepolia/Mainnet blockchain. You only need HelperConfig to run locally on your machine during the script execution so it can calculate and hand over the correct address to FundMe1.

    vm.startBroadcast();
    // FundMe1 fundMe = new FundMe1(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    // basically above method bhi harcoded address hi daal ra so what we actually gonna do is for it now refer to helperconfig file in script only
    FundMe1 fundMe = new FundMe1(ethUsdPriceFeed);
    vm.stopBroadcast();
    return fundMe;
}
}

/*
1)just ADDED return feature in the function run and now back to  Test3.t.sol file
2)return feature is quite important coz 
When you deploy a contract in a script, you want to use that contract elsewhere—especially in your unit tests (setUp()).

If your run() function doesn't return anything:
Then in your test file (FundMeTest2Prac.t.sol), you can't capture the deployed contract. You’d have to manually deploy it again in setUp(), defeating the whole purpose of using a deployment script:

3)refer helperConfig.sol file


in cmnd write forge test --fork-url $SEPOLIA_RPC_URL 
in cmnd write forge test --fork-url $MAINNET_RPC_URL  agar if i wanna deploy mainnet vala eth 
*/




/*

                                      ARCHITECTURE




                                      
┌──────────────────────────────┐
                       │        Testing Layer         │  <-- FundMeTest.t.sol
                       │ (Executes logic & asserts)   │
                       └──────────────┬───────────────┘
                                      │ calls
                       ┌──────────────▼───────────────┐
                       │       Deployment Layer       │  <-- DeployFundMe2.s.sol
                       │ (Manages chain deployment)   │
                       └──────────────┬───────────────┘
                                      │ uses
                       ┌──────────────▼───────────────┐
                       │     Configuration Layer      │  <-- HelperConfig.s.sol
                       │  (Resolves chain metadata)   │
                       └──────────────┬───────────────┘
                                      │ injects address into
                       ┌──────────────▼───────────────┐
                       │         Core Logic           │  <-- FundMe1.sol
                       │  (Pure protocol operations)  │
                       └──────────────────────────────┘











 */
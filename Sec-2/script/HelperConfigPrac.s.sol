// SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";
import {Script} from "forge-std/Script.sol";

contract HelperConfigPrac is Script{


    struct helperConfig{
        address priceFeed;
    }

    helperConfig  public priceFeedStore;

    constructor(){
        if(block.chainid == 11155111){
            priceFeedStore = getSepolia();
        }else if(block.chainid == 1){
            priceFeedStore = getMainnet();
        }else{
            priceFeedStore = getAnvil();
        }
    }

    function getSepolia() private pure returns(helperConfig memory){
        helperConfig memory sepoliaAdd = helperConfig({priceFeed:0x694AA1769357215DE4FAC081bf1f309aDC325306});
        return sepoliaAdd;
    }

    function getMainnet() private pure returns(helperConfig memory){
         helperConfig memory mainnetAdd = helperConfig({priceFeed:0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419});
         return mainnetAdd;
    }

function getAnvil() private returns(helperConfig memory){

    if(priceFeedStore.priceFeed != address(0)){
        return priceFeedStore;
    }

vm.startBroadcast();
MockV3Aggregator mock = new MockV3Aggregator(8,2000e8);
vm.stopBroadcast();

helperConfig memory anvilAdd = helperConfig({priceFeed:address(mock)});
return anvilAdd;

}
   
}
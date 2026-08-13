pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol"; 


// Why is this a library and not abstract?
// Why not an interface?

library PriceConverter1 {
    // We could make this public, but then we'd have to deploy it
    function getPrice( AggregatorV3Interface priceFeed) internal view returns (uint256) {
        // Sepolia ETH / USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
      
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(answer * 10000000000);
    }

    // 1000000000
    function getConversionRate(
        uint256 ethAmount,
         AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        // the actual ETH/USD conversion rate, after adjusting the extra 0s.
        return ethAmountInUsd;
    }
}

/*
so basically the changes i did is 
getPrice me address vali thing i deleted and directly passed the parameter

and in function getConversionRate i have added parameter of AggregatorVInterface

and we need AggregatorV3Interface inside getCOnversionRate coz its calling priceFeed and priceFeed needs aggregator interface







 */
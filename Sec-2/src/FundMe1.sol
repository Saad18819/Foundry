// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Note: The AggregatorV3Interface might be at a different location than what was in the video!
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter1} from "./PriceConverter1.sol";


// basically isme we will be studying REFACTORING THING

error FundMe_NotOwner();

contract FundMe1 {
    using PriceConverter1 for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address public /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5e18;


    AggregatorV3Interface private s_priceFeed;

// reasons to make it private 1)gas optimization 2)clear external interface basically abi me show nhi hoga toh interface remains clear 
// its simple if u make it public then under the hood it created some other functions which unnecessary use up the gas jab we know we dont wrequire public so avoid it



    constructor(address priceFeed) {
        i_owner = msg.sender;
    s_priceFeed = AggregatorV3Interface(priceFeed);
    }

    function fund() public payable {
        require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {

        return s_priceFeed.version();
    }


    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert FundMe_NotOwner();
        _;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }
    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract
    //      is msg.data empty?
    //          /   \
    //         yes  no
    //         /     \
    //    receive()?  fallback()
    //     /   \
    //   yes   no
    //  /        \
    //receive()  fallback()

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}


/*
EXPLANATION


REFACTORING AND WHY WE NEED IT
at first your FundMe contract had the Chainlink Sepolia address (0x694AA...) hardcoded directly inside it.

If your contract hardcodes a Sepolia address THEN THE PROBLEM IS:
You can't test locally for free/fast: Standard forge test (Anvil) fails because 0x694AA... is empty locally.
You can't deploy to other chains: If you want to deploy to Ethereum Mainnet, Arbitrum, or Polygon, you'd have to rewrite your contract code every time because every chain has a different Chainlink price feed address!
It violates "Clean Code" principles: A contract shouldn't care where it gets its price data, as long as the provider adheres to the AggregatorV3Interface.

THE SOLUTION
Instead of hardcoding, we inject the price feed address into FundMe when it's created, and we build helper scripts that automatically give FundMe the right address depending on where it's being deployed!





so basically its simple in get version function we wrote
  AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

  so basically yaha pe address eth sepolia ka hai so basically u are here restricitn ur self to sepolia chain only agar apan ko kahi dusri chain me deploy karna hai toh we cant ya fir baar baar address change karna padhega
  so what we actually gonna do is

  we deploy it with the address we wanna use so kinda got a hint ki constructor use karna padhega

1)In script DeployFundME1.s.sol me we directly paste the address jo aggregator me tha 
2)in constructor give parameter as address
3)and also make variable with type aggregator
4)and use that variable in constructor
5)and in get version function then delete all this aggratotr thing and use variable.version to call that thing
6)Go and make same changes in PriceConverter1.sol
7)and in fund function also add the parameter
8)also in FundMeTest2.t.sol also u gotta put address in setup function

9)but did u realise that this is a lot of work like if i update how i deploy in my script so i am also going to have to update in  test also so for it 
move on to FundMeTest3.t.sol













 */
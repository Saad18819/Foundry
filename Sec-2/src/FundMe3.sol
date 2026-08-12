// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
// WE GONNA MAKE WITHDRAW FUNCTION A LITTLE GAS EFFICIENT

// Note: The AggregatorV3Interface might be at a different location than what was in the video!
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter1Prac} from "./PriceConverter1Prac.sol";

error FundMe_NotOwner();

contract FundMe3 {
    using PriceConverter1Prac for uint256;

    mapping(address => uint256) private addressToAmountFunded;
    address[] private funders;

    // Could we make this constant?  /* hint: no! We should make it immutable! */
    address private /* immutable */ i_owner;
    uint256 public constant MINIMUM_USD = 5e18;

    AggregatorV3Interface private PriceFeedInt;

    constructor(address priceFeed){
        i_owner = msg.sender;
        PriceFeedInt = AggregatorV3Interface(priceFeed);

    }

    function fund() public payable {
        require(msg.value.getConversionRate(PriceFeedInt) >= MINIMUM_USD, "You need to spend more ETH!");
        // require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "You need to spend more ETH!");
        addressToAmountFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    function getVersion() public view returns (uint256) {
       // AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return PriceFeedInt.version();
    }


    modifier onlyOwner() {
        // require(msg.sender == owner);
        if (msg.sender != i_owner) revert FundMe_NotOwner();
        _;
    }

    function cheaperWithdraw() public onlyOwner{

        uint256 fundersLength = funders.length;
        for(uint256 funderIndex =0;funderIndex < fundersLength ; funderIndex++){
            address funder = funders[funderIndex];
             addressToAmountFunded[funder] = 0;
        }
funders = new address[](0);
  (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");


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

    function getAddressToAmountFunded(address fundingAddress) external view returns(uint256){
       return addressToAmountFunded[fundingAddress];
    }

    function getFunder(uint256 index) external view returns(address){
      return funders[index];
    }

    function getOwner() external view returns(address){
        return i_owner;
    }
}





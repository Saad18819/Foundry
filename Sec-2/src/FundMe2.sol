// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Note: The AggregatorV3Interface might be at a different location than what was in the video!
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter1Prac} from "./PriceConverter1Prac.sol";

error FundMe_NotOwner();

contract FundMe2 {
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
}// here i can like view the owner so making the owner varibale as private instead of public
// Yes, it is standard best practice in Solidity to make state variables private (or internal) and expose them via public getter functions.

/*
We gonna do changes in fund function

1)Made mapping and address as private coz when its gas efficeint and if baad me laga ki it shld be public then we can change it later on
2)now we gonna make new function getAddressToAmountFunded just to check if mapping is working properly
3)now we gonna make new function getFunder to check returned address is crct or not 
4)the above 2 functions are called as getters coz basically u are using it to to get value
5)back to FundMeTest4.t.sol





 */
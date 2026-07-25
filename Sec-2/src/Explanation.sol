/*
NOTE:for installation process go to install.sol file and then come here



3)go to github remix Fund me and copy the code from FundMe.sol and paste it to FundMe.sol file which i have made rn in src

4)go to github remix Fund me and copy the code from PriceConverter.sol and paste it to PriceConverter.sol file which i have made rn in src


now when we do forge build or compile it will give error coz

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

foundry like solidity cant directly reach out to npm package repository and we need to explicitly mention from where to pull out the dependencies



5)now search on ggole smart contract chainlink brownie contract and open the github of that and then we have to dowload this repo


6)in terminal write  'forge install 'github repo link'@ version'      can check version from github repo
forge install smartcontractkit/chainlink-brownie-contracts@1.3.0

7)now when u open lib we can see forge-std library but can also see chainlink brownie thingy as well
but now the issue is in Fundme.sol and PriceConverter.sol
"import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";"

ye aggregator vali chiz me we want chainlink contract from brownie contract which we have downloaded so we go to foundry.toml to remapp it

8)ab put the cmnd in terminal "forge build" ...it will start compiling


9)in Fundme.sol channge the line of error NotOwner(); to FundMe_NotOwner();
reason being if error mila toh we can actually point out konse file se error aaya isiliye its a best practice to do it like this


10)now go onto ExplanationOfTest.t.sol




EXPLANATION OF FOUNDRY.TOML


foundry.toml is the global configuration file for a Foundry project. It is automatically generated at the root of your directory when you run forge init. Written in TOML format, it serves as the central control panel where you define how Forge compiles, tests, debugs, and deploys your smart contracts.





Why Do We Use It? (Purpose)
Without a configuration file, Forge uses its built-in defaults. You use foundry.toml to override those defaults whenever your project grows beyond basic boilerplate. Its main purposes include:

Compiler Control: Specifying the exact Solidity language version (solc), changing optimization runs to save deployment gas, or switching to external custom compilers like zksolc for L2 networks.

Library Remappings: Teaching Forge how to resolve shorthand imports (like path shortcuts for @chainlink or @openzeppelin) so your code compiles cleanly.

Testing Environments: Adjusting how fuzz tests behave (e.g., how many random inputs it should generate to break your code) or setting up global RPC endpoints for network forking.

Security Management: Configuring safety guardrails, such as explicitly permitting or denying local file system read/write access for your Solidity test cheatcodes.








*/
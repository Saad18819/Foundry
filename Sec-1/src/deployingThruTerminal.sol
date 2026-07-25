/*
1)forge --help

it will give all the command that forge comes with

2)In the command line world, adding --help at the end of a command tells the tool: "Hey, give me the instruction manual for this specific feature."


3)forge create --help

it will give all the command that forge create comes with

4)this is what i actually wrote in the terminal to deploy the contract

forge create src/SimpleStorage.sol:SimpleStorage \--rpc-url http://127.0.0.1:8545 \--interactive \--broadcast

this is the result i got in the terminal after running the above command

Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0xb477598bf3e386ed84731c52fb2dfc8b8981ffc3a6537ba26a867f6644953cc2

EXPLANATION OF THE COMMAND I WROTE IN THE TERMINAL TO DEPLOY THE CONTRACT

1. forge create
What it means: "Hey Foundry, deploy a brand new contract."

The Details: forge is your primary development tool. The create subcommand tells it that you aren't just building or testing code anymore—you want to take a compiled contract and initialize it as a live instance on a blockchain network.




2. src/SimpleStorage.sol:SimpleStorage
What it means: "Here is the exact file path and the exact contract name inside that file."

The Details: This follows the syntax path/to/File.sol:ContractName.

src/SimpleStorage.sol tells Forge exactly where to look on your computer's hard drive to find the file.

:SimpleStorage specifies the exact contract name inside that file to deploy (which matters if you have multiple contracts written inside a single .sol file).






3. --rpc-url http://127.0.0.1:8545
What it means: "Send this contract over the internet to my local Anvil node."

The Details: An RPC (Remote Procedure Call) URL is the bridge or doorway into a blockchain network.

http://127.0.0.1 (also known as localhost) means your own computer.

:8545 is the specific port number that your anvil terminal is listening to. This tells Forge to route the compiled contract directly to your active Anvil testing environment.




4. --interactive

What it means: "Prompt me for my private key securely; do not look for it in the command itself."

The Details: As Patrick Collins warned you, typing a private key directly into a command saves it forever in your terminal history files. --interactive stops the process right before deployment, blanks out your input line, and securely accepts your Anvil private key without saving a trace of it on your system.



5. --broadcast
What it means: "Stop simulating! Actually pay the gas fee and publish this transaction to the network."

The Details: Without this flag, Forge defaults to a "dry run" safety simulation. Adding --broadcast gives Forge the green light to take your signed transaction, send it to Anvil, spend the fake test ETH on gas, and permanently save the contract state to your local blockchain ledger.




THE EXACT CMND TO PUT IN TERMINAL

forge create src/SimpleStorage.sol:SimpleStorage \--rpc-url http://127.0.0.1:8545 \--interactive \--broadcast





and lets say if i am using anvil and directly wanna deploy the file without making file in script folder then put this command in terminal

forge create src/MyContract.sol:MyContract \--rpc-url http://127.0.0.1:8545 \--private-key <ANVIL_PRIVATE_KEY>

*/
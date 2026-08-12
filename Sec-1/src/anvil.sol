/*
Think of Anvil like a video game "sandbox mode" or an offline training simulator, but built specifically for blockchain developers.

Normally, to test a smart contract (a blockchain program), you would have to deploy it to the real Ethereum network. That requires waiting for miners to process it and spending real money (gas fees).

When you type " anvil" into your computer's terminal, it creates a fake, private, ultra-fast version of Ethereum that runs entirely inside your computer's memory.





Deploying a smart contract locally using Anvil inside a Windows Subsystem for Linux (WSL) terminal is straightforward because Anvil treats WSL like a native Linux environment.



Step1 : in wsl terminal, run the command to start Anvil: anvil

Anvil will spin up a local Ethereum node listening on http://127.0.0.1:8545. It provides 10 test accounts, each pre-funded with 10,000 test ETH, along with their respective Private Keys. Keep this terminal window running.

then open metamask and connect to the local network by adding a custom network with the RPC URL http://127.0.0.1:8545 given at the end in terminal and also in the terminal we get the chain Id as well

RPC network means Remote Procedure Call network. In the context of Ethereum, an RPC network allows your wallet (like MetaMask) to communicate with the Ethereum blockchain (or a local instance like Anvil) by sending requests and receiving responses.

rpc is like an api call typa shit

and then in metamask, import one of the test accounts using its Private Key. This will allow you to interact with the local Ethereum node and deploy smart contracts without spending real ETH.

import account means adding an account thats not own by metamask but you have the private key for it, so you can use it to sign transactions and interact with the blockchain.



You can write anvil inside either folder (foundry or foundry/Sec-1). It makes absolutely no difference to Anvil.

As long as you are inside your WSL terminal, you can type anvil from anywhere, and it will start the exact same local blockchain.

However, for the other commands (like forge build or forge create), your directory location matters a lot.



and after above thing there are 2 methods to deploy it


Method A: Using your script file (Recommended)

forge script script/DeploySimpleStorage.s.sol \
  --rpc-url http://127.0.0.1:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 \
  --broadcast





  Method B: The quick command-line shortcut (No script needed)

  forge create src/SimpleStorage.sol:SimpleStorage \
  --rpc-url http://127.0.0.1:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80



  What to look for next:
Once you hit enter on either command:

In your working terminal, Forge will compile the code, spit out a transaction hash, and output the exact Deployed to: contract address.

In your Anvil terminal, you will instantly see blocks flashing by as it processes the eth_sendRawTransaction.

You can then grab that contract address from your terminal to interact with it via MetaMask or Cast!



! If you want to control that contract or see the transaction history inside MetaMask, you should use the exact same private key that you imported into MetaMask.
















That is a completely fair question. If the terminal does 100% of the heavy lifting to actually put the contract on the blockchain, why bother messing around with MetaMask at all?

The short answer: You don't need MetaMask to deploy. Your terminal handles deployment entirely on its own.

You only import that key into MetaMask if you want to interact with your contract through a web browser UI after it is deployed.like when u connecting frontend and all and when u deploy u want metamask to approve sending gas and all
*/
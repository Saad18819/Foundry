/*
CLI:COMMAND LINE INTERFACE

To interact with a deployed smart contract directly from your terminal, Foundry provides a powerful CLI tool called cast.
cast send, which is specifically used to publish a transaction onto the blockchain that alters the state

1)make sure anvil running in the other teminal
2)and then depoly the contract through terminal by using
"cast wallet import nameofaccount(anything works) --interactive"
and then after all the ques terminal ask run this
"forge script script/DeploySimpleStorage2.s.sol:DepolySimpleStorage2 --rpc-url http://localhost:8545 --account defaultKey --sender 0xf39fd6e51aad88f0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266(the adress generated where private key is stored) --broadcast -vvvv

now after deployment

3)foundry has another in built tool called cast and if u type "cast --help" we will get a whole bunch of command that deals with cast
4)one of the cmnd is "send" which can find more abt it by typng "cast send --help" and read the ARGUMENTS part
5)send is used for     Sign and publish a transaction

for example lets say we have a store function which stores the value so how to store the value in it through terminal the code is written in SimpleStorage.sol
cast send <CONTRACT_ADDRESS after deploying the contract> "store(uint256)" <VALUE to be stored> --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
EXAMPLE: "cast send  0x8464135c8F25Da09e49BC8782676a84730C318bC "store(uint256)" 123 --rpc-url http://127.0.0.1:8545 --private-key 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a"



EXPLANATION OF THE TERMINAL CODE

cast send: Tells Foundry you want to sign and broadcast a state-changing transaction to the network.

<CONTRACT_ADDRESS>: The hexadecimal cryptographic address of your deployed contract on the network (e.g., 0x5FbDB2315678afecb367f032d93F642f64180aa3 if you are using a local Anvil instance).

"store(uint256)": This is the function signature.

It tells the contract exactly which function you want to call.

Crucial Rule: There must be no spaces inside the parentheses (write uint256, not uint256 ).

<VALUE>: The actual argument you are passing into the function. If you want to store the number 42, you simply put 42 here.



6)after running that in terminal we will get ino like block number blah blah so in order to read this we will use "cast call" but cast call is like cast send only but its for blue button not sending a transaction just doing a view function
to view what number has been stored we will use
 "cast call <contract address> "retrieve function(given inside code)"
 EXAMPLE:  cast call 0x7ef8E99980Da5bcEDcF7C10f41E55f759F6A174B "retrieve()"

 and we will get the hex value back and to convert that hex value we use     "cast --to-base <paste the hex value> dec"
EXAMPLE:   cast --to-base 0x000000000000000000000000000000000000000000000000000000000000007b dec


so basically what it is actually that in remix after deployment we get multiple button based on view or actually deployed so we use cast send if we are using orange vala button and use cast call if we using vuew typa shit












ACTUALL CODE TO PUT IN TERMINAL



1)anvil (in diff terminal)
2)open new terminal
3)"cast wallet import nameofaccount(anything works) --interactive"
4)forge script script/DeploySimpleStorage2.s.sol:DepolySimpleStorage2 --rpc-url http://localhost:8545 --account defaultKey --sender 0xf39fd6e51aad88f0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266(the adress generated where private key is stored) --broadcast -vvvv
5)cast send <CONTRACT_ADDRESS after deploying the contract> "store(uint256)" <VALUE to be stored> --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
6)cast call <contract address> "retrieve function(given inside code)
7)cast --to-base <paste the hex value> dec








 */
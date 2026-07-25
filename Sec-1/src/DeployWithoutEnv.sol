/*
in terminal go and write "cast wallet import nameofaccount(anything works) --interactive"
then it will ask for the pirvate key:
then password:which i have to write down for the first time and make sure to remember it
and then it will give the address where its stored

and then u can write in terminal "cast wallet list" and hit enter, it will give the list of all the accounts that are stored in the keystore folder with the name we wrote above for the accnt

and in terminal to deploy run this

forge script script/DeploySimpleStorage2.s.sol:DepolySimpleStorage2 --rpc-url http://localhost:8545 --account defaultKey --sender 0xf39fd6e51aad88f0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266(the adress generated where private key is stored) --broadcast -vvvv

and then it will ask for the password which we have set initially so u goota remember it or make password.file to store the password which is better than storing private key in .env file and then the contract is deployed to anvil blockchain and it will give the address of the deployed contract in the terminal












*/
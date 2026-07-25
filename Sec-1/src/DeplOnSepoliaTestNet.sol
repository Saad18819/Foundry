/*
STEPS TO DEPLOY TRANSCTION ON SEPOLIA TESTNET

1)through resource go and find deploy to a testnet and from alchemy using make a new app from there get RPC URL and paste that in .env file
2)from metamask get the private key of the accnt which has sepolia and also paste that in .env file

IN TERMINAL NOW

3)source .env
4)forge script script/DeploySimpleStorage2.s.sol:DepolySimpleStorage2 --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast
5)and boom u have deployed the contract

6)we can check the report on alchemy abt the stats and can also go to etherscan.io to check the transaction by copying the hash from the terminal which has generated after deployment
7)also u would see in the broadcast folder under new chainid run file has been formed with transaction object

























 */
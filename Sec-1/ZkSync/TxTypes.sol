/*
so basically we know there are three type of transaction type 0(OxO) ,type 1(Ox1) , type2(Ox2)

when we usee --legacy in terminal it will send type zero transaction
forge script script/DeploySimpleStorage.s.sol --rpc-url http://127.0.0.1:8545 --private-key ${private-key} --broadcast --legacy


and without --legacy it will send type two transaction mostly coz sometimes type 1 bhi hojaata


and we have one more type Ox71 or txn113 which is specific to zk sync ecosytem and many ecosystem have different type of transaction pretty much all evm ecosystems have at least type 0,1,2



A lil bit difference in anvil and zksync

IN ANVIL:

Without --legacy (Default): Anvil expects a Type 2 (EIP-1559) transaction

With --legacy: If you pass --legacy to Anvil, it will adapt perfectly. and it will be a type2 transaction




IN ZKSync ERA

Standard forge script will fail: If you try to run your normal standard Ethereum forge script ... --rpc-url <zksync-rpc> (with or without --legacy), the deployment will usually reject or fail. ZKsync's sequencer expects the transaction to be formatted in its unique Type 0x71 envelope so it can process factory dependencies and custom execution logic.




he ZKsync Solution: Instead of using standard Foundry flags to toggle between Type 0 and Type 2, you use foundry-zksync (a specific fork of Foundry maintained by the Matter Labs / ZKsync team). When deploying to ZKsync, you pass a specialized flag:
forge script script/DeploySimpleStorage.s.sol --rpc-url <zksync_rpc> --zksync --broadcast


The --zksync flag tells the compiler to optimize the output for the zkEVM and forces the deployer to pack the transaction into the 0x71 format.








Zksync is L2 netowrk and Sepoliad testnet is L1

*/
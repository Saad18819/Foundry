/*
so basically its simple if u gonna deploy on main ehtereum chain its way too expensive like when cyfrin searched abt it for this small amnt of line of codes u gotta pay $7 for frkn 30-35 lines of code which is next to impossible

and the calculation part u can do like for example in broadcst folder check "run-latest .json" there in it they have the info abt gas used and then go to etherscan and check the gas price of the tranasction we did and convert that into eth and then use eth to usd converter to find out how much money we have spent

to deploy to zksync sepolia its similar how we deployd by using anvil and u just gotta need rpc url which we can get from alchemy

in 'run-latest.json' we can go and check the receipt part where we can find out the type of transactions happened





The core difference is the target blockchain environment and how your code gets compiled. Vanilla Foundry is built for standard EVM chains (like Ethereum, Arbitrum, Optimism), whereas ZKsync Foundry is a specialized toolchain built specifically for ZKsync Era and its unique architecture.
 in simple lang vnilla foundry is deployed on L1
 and zksync foundry on L2





 In Vanilla Foundry, you run forge build or forge test and it instantly executes.
In ZKsync Foundry, the toolchain adds ZKsync-specific flags to let the backend know you want to target the EraVM:

forge build --zksync

forge test --zksync
*/
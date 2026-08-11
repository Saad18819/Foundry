# A Makefile acts as a cheat sheet or automation hub for your terminal commands.

# automatically grabs whatsoever is in our .env without us doing source .env in terminal
# learn how to download make tools through gpt
-include .env

build:; forge build  
# now when u write "make build" it wil run the cmnd forge build
# u use ; if we wanna write cmnd on same line for different line u dont write u just hit enter and write

deploy-sepolia:
   forge script script/DeployFundMe.s.sol:DeployFundMe --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv


# in make file u need to circle ur env varibales


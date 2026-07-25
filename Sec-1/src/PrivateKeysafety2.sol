/*
we will learn how to interact with contract through terminal


forge script script/DeploySimpleStorage.s.sol:DeploySimpleStorage --rpc-url http://127.0.0.1:8545 --broadcast --private-key <private key of the account that we want to use to deploy the contract (use anvil ki private key)>



ab isme issue ye hai u are writing the private key inside the terminal and its risky because anyone who has access to your terminal can see the private key and use it to steal your funds
even if write interactive jisse u cant see the private key and cant directly paste it but interactive doest work with scripts


STEPS TO SOLVE IT

1)create a new file .env in root folder
2)whenever we create a .env file the first thing you shld do go to a git ignore file and add .env in it so that the .env file is not pushed to github and no one can see the private key
3)in .env file put environment variables that are sensitive that we dont want to share with anyone like private key, api keys etc
4)in .env file now go and see the code
5)after writing the code in .env file go to terminal and write "source .env" and then hit enter, this will load the environment variables from .env file into the terminal session
6)if after writing "source .env file" in terminal and if we got error :command not found then write" sed -i 's/\r$//' .env" and then write "source env"






This command fixes a hidden structural conflict between Windows and Linux called Line Endings.

When you press Enter to start a new line in a file:

Windows inserts two hidden characters: Carriage Return (\r) and Line Feed (\n). This is known as CRLF.

Linux/Ubuntu (WSL) only uses one character: Line Feed (\n). This is known as LF.

Because your project is living on your Windows drive (/mnt/c/...), VS Code saved your .env file using Windows CRLF.

# This command is an invisible eraser. It fixes a conflict between Windows and Linux line endings by finding any hidden Windows "carriage return" characters (\r) at the end of each line in this file and wiping them out, allowing the Linux/WSL terminal to read and source our environment variables without throwing errors.



7)then write "echo $PRIVATE_KEY" in terminal and hit enter, if it prints the private key then it means the environment variable is loaded successfully and we can use it in our forge script command to deploy the contract to anvil blockchain
8)then write "echo $RPC_URL" in terminal and hit enter, if it prints the rpc url then it means the environment variable is loaded successfully and we can use it in our forge script command to deploy the contract to anvil blockchain
9)now to deploy we will use this command
forge script script/DeploySimpleStorage.s.sol:DeploySimpleStorage --rpc-url $RPC_URL --broadcast --private-key $PRIVATE_KEY

10)important thing is  it is necessary to keep Anvil running in its own separate terminal window while you use a second terminal to run your deployment script.
11)so tht source .env shld be written in the same terminal window where we are going to run the forge script command to deploy the contract to anvil blockchain else it will not work



PART 2 to make it more secure and for production level this is way more secure that storing it in .env file coz if we uploaded the file unintentionally to github then the private key will be compromised and anyone can use it to steal your funds

1)in terminal write forge script --help and hit enter, it will give all the commands that forge script comes with
2)in wallet option we have this " --keystore <PATHS>"
3)keystore is a file that contains the private key of the account but encrypted by a password and u just need password to de-encrypt it  that we want to use to deploy the contract, so that we dont have to write the private key in the terminal and it will be more secure


 */
/*
1)The foundry we have been using till now is the vanilla foundry and now we gonna use the ZK sync foundry its the foundry itself but with a little bit of tweaks and all


2)go to resource part of foundry zksync and scroll down a lil bit to the installation process 

STEPS to put in terminal

1)curl -L https://raw.githubusercontent.com/matter-labs/foundry-zksync/main/install-foundry-zksync | bash

2)foundryup-zksync  (will install the latest addition of foundry zksync into our terminal)

3)foundryup --update  

the above is to update the latest version

4)forge build --zksync


and now if i put the cmnd "forge build --help" it will give the zk sync ka portion as well now

and if i wanna go back to vanilla foundry just write this in terminal "foundryup"  and now if u run  "forge build --help"  u wont see any zksync thing in the terminal  and if again i wanna switch back to zk sync foundry then  in the terminal "foundryup-zksync" then again we can see the k sync commmands back in the terminal

just a advice try to be in the vanilla foundry and whenever u need to switch to uk what to do

 when we ran the forge build command, it generated an /out folder in the root project directory. This folder contains all the compilation details related the Ethereum Virtual Machine (EVM) and Vanilla Foundry. 
 To compile for the ZKsync chain instead, we use the command forge build --zksync. This command creates a new folder in our project root called /zkout, and contains all the compiled code compatible to the ZKsync Era VM.




If we need to revert to vanilla Foundry for deployment on the EVM, we simply run the command foundryup and then use forge build, which builds a standard Foundry project. Unless otherwise specified, we should continue using this method.

*/
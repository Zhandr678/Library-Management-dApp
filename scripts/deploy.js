
const hre = require("hardhat");

const main = async()=>{
    const libContract = await hre.ethers.deployContract("Library");
    await libContract.waitForDeployment();
    console.log("Contract deployed to: ", libContract.target);
}

const runMain = async()=>{
    try{
        await main();
        process.exit(0);
    }catch(error){
        console.log(error);
        process.exit(1);
    }
}


runMain();

// Deployed to: 0x1Fa7eDC3ED2D0fB71b16379638cC1A68f1187635 (Alchemy)

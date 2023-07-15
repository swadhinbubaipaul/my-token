// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const myToken = await hre.ethers.deployContract("MyToken", [
    "MyToken",
    "MTK",
    "1000000000000000000000000000000000000",
    "0xc5E5Be3602995A7F0BD737E0931D776a0Bcc336F",
    "2",
  ]);

  await myToken.waitForDeployment();
  console.log(`MyToken contract deployed to ${myToken.target}`);

  const advancedMyToken = await hre.ethers.deployContract("AdvancedMyToken", [
    "0xc5E5Be3602995A7F0BD737E0931D776a0Bcc336F",
    "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D",
  ]);

  await advancedMyToken.waitForDeployment();

  console.log(`AdvancedMyToken contract deployed to ${advancedMyToken.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

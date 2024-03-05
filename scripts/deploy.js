// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
require("dotenv").config();
const hre = require("hardhat");

FIRST_MINT_PRICE = ethers.utils.parseEther("0.2");
MINT_PRICE = ethers.utils.parseEther("0.1");
FIRST_MINT_AMOUNT = 10;

async function main() {
  const GachaCard = await hre.ethers.getContractFactory("GachaCard");
  const gachaCard = await GachaCard.deploy(
    FIRST_MINT_PRICE,
    MINT_PRICE,
    FIRST_MINT_AMOUNT
  );

  console.log("GachaCard deployed to:", await gachaCard.getAddress());
}

main()
  .then(() => (process.exitCode = 0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });

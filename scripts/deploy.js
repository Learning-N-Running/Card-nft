// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.

async function main() {
  const TinaCard = await hre.ethers.getContractFactory("TinaCard");
  const tinacard = await TinaCard.deploy("TinaCard", "TC");

  await tinacard.deployed();

  console.log("TinaCard deployed to:", tinacard.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

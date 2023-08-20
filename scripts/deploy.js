// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.

async function main() {
  const MyCryptoLions = await hre.ethers.getContractFactory("MyCryptoLions");
  const myCryptoLions = await MyCryptoLions.deploy("MyCryptoLions", "MCL");

  await myCryptoLions.deployed();

  console.log("MyCryptoLions deployed to:", myCryptoLions.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

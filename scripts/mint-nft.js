require("dotenv").config();
const SEPOLIA_API_URL = process.env.SEPOLIA_API_URL;
const { createAlchemyWeb3 } = require("@alch/alchemy-web3");
const web3 = createAlchemyWeb3(SEPOLIA_API_URL);

const contract = require("../artifacts/contracts/MyNFT.sol/TinaCard.json");
console.log(JSON.stringify(contract.abi));

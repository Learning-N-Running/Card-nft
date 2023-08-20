require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */

const SEPOLIA_PRIVATEKEY = process.env.SEPOLIA_PRIVATEKEY;
const hex = utf8ToHex(SEPOLIA_PRIVATEKEY ?? "");

module.exports = {
  solidity: "0.8.18",
  networks: {
    sepolia: {
      url: `https://eth-sepolia.g.alchemy.com/v2/${SEPOLIA_PRIVATEKEY}`,
      accounts: [`0x${hex}`],
    },
  },
};

function utf8ToHex(str) {
  return Array.from(str)
    .map((c) =>
      c.charCodeAt(0) < 128
        ? c.charCodeAt(0).toString(16)
        : encodeURIComponent(c).replace(/\%/g, "").toLowerCase()
    )
    .join("");
}

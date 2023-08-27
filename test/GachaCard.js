const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

FIRST_MINT_PRICE = ethers.utils.parseEther("0.2");
MINT_PRICE = ethers.utils.parseEther("0.1");
FIRST_MINT_AMOUNT = 10;

describe("TinaGachaCard", () => {
  let GachaCard;
  let gachaCard;

  beforeEach(async () => {
    GachaCard = await ethers.getContractFactory("GachaCard");
    gachaCard = await GachaCard.deploy(
      FIRST_MINT_PRICE,
      MINT_PRICE,
      FIRST_MINT_AMOUNT
    );
    await gachaCard.deployed();
  });

  describe("Constructor", () => {
    it("Should initialize first mint price / mint price / first mint amount properly", async () => {
      const firstMintPrice = await gachaCard.getFirstMintPrice();
      const mintPrice = await gachaCard.getMintPrice();
      const firstMintAmount = await gachaCard.getFirstMintAmount();

      assert.equal(Number(firstMintPrice), Number(FIRST_MINT_PRICE));
      assert.equal(Number(mintPrice), Number(MINT_PRICE));
      assert.equal(Number(firstMintAmount), Number(FIRST_MINT_AMOUNT));
    });
  });
});

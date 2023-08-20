/*HelloWorld.js*/
const { expect } = require("chai");

describe("MyCryptoLions", function () {
  it("Should return the right name and symbol", async function () {
    const MyCryptoLions = await hre.ethers.getContractFactory("MyCryptoLions");
    const myCryptoLions = await MyCryptoLions.deploy("MyCryptoLions", "MCL"); //HelloWorld.sol의 constructor에 해당하는 argument 전달
    expect(await myCryptoLions.name()).to.equal("MyCryptoLions"); //이렇게 나올 것으로 예상된다.
    expect(await myCryptoLions.symbol()).to.equal("MCL");
  });
});

// describe("MyCryptoLions", function () {
//     it("Should return the right name and symbol", async function () {
//       const MyCryptoLions = await hre.ethers.getContractFactory("MyCryptoLions");
//       const myCryptoLions = await MyCryptoLions.deploy("MyCryptoLions", "MCL"); //HelloWorld.sol의 constructor에 해당하는 argument 전달

//       await myCryptoLions.deployed();
//       expect(await myCryptoLions.name()).to.equal("MyCryptoLions"); //이렇게 나올 것으로 예상된다.
//       expect(await myCryptoLions.symbol()).to.equal("MCL");
//     });
//   });

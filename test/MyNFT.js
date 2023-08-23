const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyTinaCard", function () {
  let TinaCard;
  let tinacard;
  let owner;
  beforeEach(async function () {
    //각각의 테스트 케이스가 실행되기 전에 먼저 실행됨 //테스트 환경을 설정하거나 초기화
    TinaCard = await ethers.getContractFactory("TinaCard");
    tinacard = await TinaCard.deploy(
      "TinaCard",
      "TC",
      0,
      process.env.PUBLIC_KEY
    ); //MyNFT.sol의 constructor에 해당하는 argument 전달
    [owner] = await ethers.getSigners();
  });

  it("Should set new issuance cost", async function () {
    const newCost = ethers.utils.parseEther("0.1");
    // Call setIssuanceCost function
    await tinacard.connect(owner).setIssuanceCost(newCost); // 컨트랙트 배포 계정(소유자 계정)을 연결해 컨트랙트 함수 호출
    // Check if the issuance cost has been updated
    expect(await tinacard.issuanceCost()).to.equal(newCost);
  });

  it("Should mint NFT and increase total supply", async function () {
    const initialSupply = await tinacard.totalSupply();
    const issuanceCost = await tinacard.issuanceCost();

    // Mint an NFT
    const mintTx = await tinacard
      .connect(owner)
      .mintNFTs(owner.address, { value: issuanceCost });
    await mintTx.wait(); //트랜잭션이 완료될 때까지 기다린 다음 다음 코드로 넘어감

    /**
     * 옵션객체: smart contract 함수를 호출할 때 추가 설정을 제공하는 javascript 객체
     * ex) { value: issuanceCost } : NFT 발행할 때 발행 비용 이상의 이더를 보내야 하기에 이를 옵션 객체로 사용하여 지정
     * value: 이더(Ether)를 함께 전송하는 데 사용되는 옵션입니다. 스마트 계약 함수를 호출할 때 해당 함수가 지불되어야 하는 이더 금액을 설정
     * gas limit이나 gas price와 같은 다른 설정을 지정할 수도 있음.
     */

    console.log(await tinacard.totalSupply());

    // Check total supply and NFT ownership
    expect(await tinacard.totalSupply()).to.equal(initialSupply.add(1)); //민팅이 됐으면 하나가 더 증가할 것
    expect(await tinacard.ownerOf(initialSupply)).to.equal(owner.address);
  });
});

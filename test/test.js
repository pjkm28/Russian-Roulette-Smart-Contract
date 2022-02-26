const { expect } = require("chai");


describe("Token Contract", function () {
  it("Should assign the total supply of tokens to the owner", async function () {
    const [owner] = await ethers.getSigners();
    
    console.log("Signers object : ",owner);
    
    const Token = await ethers.getContractFactory("Token"); // instance created

    const hardhatToken = await Token.deploy(); // contract deployed

    const ownerBalance = await hardhatToken.CheckBalance(owner.address);

    console.log("Owner Address : ",owner.address);
    console.log("Owner Balance : ",ownerBalance);

    expect (await hardhatToken._totalSupply()).to.equal(ownerBalance)
  })
});

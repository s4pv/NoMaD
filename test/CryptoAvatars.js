const CryptoAvatars = artifacts.require("CryptoAvatars");
const avatarSex = ["Male", "Female"];
contract("CryptoAvatars", (accounts) => {
   let [alice, bob] = accounts;
   it("should be able to create a new avatar", async () => {
        const contractInstance= await CryptoAvatars.new();
        const result = await contractInstance.createRandomAvatar(avatarSex[1],{from: alice});
        assert.equal(result.receipt.status, true);
        assert.equal(result.logs[0].args.sex,avatarSex[1]);
   })
 }

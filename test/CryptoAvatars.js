const CryptoAvatars = artifacts.require("CryptoAvatars");
const utils = require("./helpers/utils");
const time = require("./helpers/time");
var expect = require('chai').expect;
const avatarSex = ["Male", "Female"];
contract("CryptoAvatars", (accounts) => {
   let [alice, bob] = accounts;
   let contractInstance;
   let oneEtherInWei = web3.utils.toWei('1', 'ether');

   beforeEach(async () => {
    contractInstance = await CryptoAvatars.new( {from: alice});
    });

   it("should be able to create a new avatar", async () => {
        const result = await contractInstance.createRandomAvatar("Male", {from: alice, value: 0.1 * oneEtherInWei});
        expect(await web3.eth.getBalance(contractInstance.address)).to.equal('100000000000000000');
        expect(result.receipt.status).to.equal(true);
        expect(result.logs[0].args.avatarSex).to.equal(avatarSex[0]);
   })

   /*it("should not allow two avatars", async () => {
        await contractInstance.createRandomAvatar(avatarSex[1], {from: alice});
        await utils.shouldThrow(contractInstance.createRandomAvatar(avatarSex[0], {from: alice}));
   })

    context("with the single-step transfer scenario", async () => {
        it("should transfer an avatar", async () => {
           const result = await contractInstance.createRandomAvatar(avatarSex[1], {from: alice});
           const avatarId = result.logs[0].args.avatarId.toNumber();
           await contractInstance.transferFrom(alice, bob, avatarId, {from: alice});
           const newOwner = await contractInstance.ownerOf(avatarId);
           expect(newOwner).to.equal(bob);
        })
    })

    context("with the two-step transfer scenario", async () => {
        it("should approve and then transfer an avatar when the approved address calls transferFrom", async () => {
            const result = await contractInstance.createRandomAvatar(avatarSex[1], {from: alice});
            const avatarId = result.logs[0].args.avatarId.toNumber();
            await contractInstance.approve(bob, avatarId, {from: alice});
            await contractInstance.transferFrom(alice, bob, avatarId, {from: bob});
            const newOwner = await contractInstance.ownerOf(avatarId);
            expect(newOwner).to.equal(bob);
        })
        it("should approve and then transfer an avatar when the owner calls transferFrom", async () => {
            const result = await contractInstance.createRandomAvatar(avatarSex[0], {from: alice});
            const avatarId = result.logs[0].args.avatarId.toNumber();
            await contractInstance.approve(bob, avatarId, {from: alice});
            await contractInstance.transferFrom(alice, bob, avatarId, {from: alice});
            const newOwner = await contractInstance.ownerOf(avatarId);
            expect(newOwner).to.equal(bob);
        })
        it("avatars should be able to breed another avatar", async () => {
            let result;
            result = await contractInstance.createRandomAvatar(avatarSex[1], {from: alice});
            const firstAvatarId = result.logs[0].args.avatarId.toNumber();
            result = await contractInstance.createRandomAvatar(avatarSex[0], {from: bob});
            const secondAvatarId = result.logs[0].args.avatarId.toNumber();
            await time.increase(time.duration.days(1));
            await contractInstance.breed(firstAvatarId, secondAvatarId, {from: alice});
            expect(result.receipt.status).to.equal(true);
        })
    })*/
})
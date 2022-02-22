# NoMad_

# META Problem:
Create an RPG Game/Dapp (Solidity) on an Ethereum fork with an economy/ecosystem that solves:

Metaverse Inmersion.

Web3.

Real life goals instead of consumer behavior oriented. Real life traveling.

Community building.

Efficient Consensus Mechanism based on actual blockchain capabilities and game needs.


# 1st Approach: P2E Game (not pay to earn): NoMad_ – CryptoZombies “fork”

Consensus Mechanism: Proof of Work. If you stay on a fixed real place (Workplace) for several hours, your avatar will start to WORK, mining MAD tokens. (Through glasses, smartwatch, notebook, and phone if possible, available and permissioned)

When you TRAVEL, you will earn NOMAD tokens (through an internal dex/swap staking or liquidity providing system of your tokens while traveling). Additional proofs may be needed and posted public or private. (photos, videos, delta-time, non-VPN GPS validation, QR scans, etc)

You can also mint pure AVATARS, or on the market you can trade AVATARS (NFT), PIECES (NFT) for MAD & NOMAD tokens respectively. Also you can migrate your existing NFTs: CypherPunks, BoredApes, etc.

You can BREED (mint) AVATARS (2 AVATARS -> a new AVATAR with mixed DNA) and MERGE (mint) PIECES (2 PIECES -> new PIECE with mixed characteristics) using MAD & NOMAD tokens which will be burnt.

NOMAD Tokens are inflationary and MAD tokens are deflationary. MAD tokens are the governance token for community building.

Through an achievement points system, leveling, stats and race, the AVATAR have special real-life abilities and different quests access. Similar applies for PIECES.

AVATAR and PIECE abilities will grant a real-life connection ecosystem while at the same time incentivizing real traveling: traveling discounts, hotel rooms discounts, breakfasts, etc.

There will be QRs/NPCs on public plazas, airports, and public attractions near great cities all around the world, where you can start/end proof of TRAVEL quests and buy/sell travel stuff with ingame tokens.


# Installation requirements:

npm install -g solc

npm install -g npm

npm install -g truffle

npm install truffle-hdwallet-provider

npm install -g web3

npm install -g mocha

npm install -g ganache-cli

npm install --save-dev chai


# Testing:

Instances in truffle.js & truffle-config.js written for testing:

Rinkeby network ->not available

loom network -> not available

development local network -> choosen


Testing with truffle + ganache client:

truffle init

ganache-cli -p 7545    

truffle compile

truffle migrate --network development

truffle test

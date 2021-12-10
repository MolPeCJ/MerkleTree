const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

const whitelistAddresses = [
  '0x5B38Da6a701c568645dCfcB03FcB875f56beddC4',
  '0x78D6CF3DEF45AF458442E787FE6E64A03750AB94',
  '0xA7B0E4CF55AF900F6E80D619AE1E00965044BC4E',
  '0x38C4278F42A26A588176017F5E4F6ED831835EA2',
];

const leafNodes = whitelistAddresses.map((addr) => keccak256(addr));
const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });

const rootHash = merkleTree.getRoot();

console.log('Root hash\n', rootHash.toString('hex'));
console.log('Whitelist Merkle Tree\n', merkleTree.toString());

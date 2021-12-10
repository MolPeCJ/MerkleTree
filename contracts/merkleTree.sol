// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

// Import for OpenZeppelin MerkleProof contract. This will allow us to use
// the 'MerkleProof.verify' method
import "../contracts/merkleProof.sol";

contract Merkle {

    // The root hash of the Merkle Tree we previously generated in our JavaScrupt code. Remember
    // to provide this as a bytes32 type and not a string. 0x should be pretended
    bytes32 public merkleRoot = 0x84a6635c31183dda4a6f620f100b465c603d7280e316e9eb98bca68ae23c9916;

    // Mapping variable to mark whitelist addresses as having claimed
    mapping(address => bool) public whitelistClaimed;

    // In a real contract, this would be your minting function. Therefore it would
    // feature the payable keyword
    function whitelistMint(bytes32[] calldata _merkleProof) public {

        // Basik data validation to ensure the wallet hasn't already claimed
        require(!whitelistClaimed[msg.sender], "Address has already claimed");
        
        // Verify the provided _merkleProof, given to us through the API call on our website
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid proof");

        // Mark address as having claimed their token
        whitelistClaimed[msg.sender] = true;

        // Mint the reserved token here
    }
}
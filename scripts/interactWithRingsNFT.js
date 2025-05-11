const { ethers } = require("hardhat");

async function main() {
  // Replace these with actual values
  const DEPLOYED_CONTRACT_ADDRESS = "0x123...abc"; // deployed contract address
  const RECIPIENT_ADDRESS = "0xA5c...def"; // address to receive the minted token
  const TOKEN_URI = "https://ipfs.tech/ipfs/1"; // URI for the token metadata

  try {
    // Get the contract factory for RingsNFT
    const RingsNFT = await ethers.getContractFactory("RingsNFT");

    // Attach to the deployed contract
    const ringsNFT = await RingsNFT.attach(DEPLOYED_CONTRACT_ADDRESS);

    console.log("Attached to RingsNFT contract at:", DEPLOYED_CONTRACT_ADDRESS);

    // Call the mintToken function
    const tx = await ringsNFT.mintToken(RECIPIENT_ADDRESS, TOKEN_URI);

    // Wait for blockchain confirmation
    await tx.wait();

    console.log("Token minted successfully!");
  } catch (error) {
    console.error("Error minting token:", error);
  }
}

// Run the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

const hre = require("hardhat");

async function main() {
  console.log("Deploying RingsNFT contract...");

  const RingsNFT = await hre.ethers.getContractFactory("RingsNFT");
  const ringsNFT = await RingsNFT.deploy();

  await ringsNFT.waitForDeployment();

  const address = await ringsNFT.getAddress();
  console.log("RingsNFT deployed to:", address);

  // Wait for a few block confirmations
  console.log("Waiting for block confirmations...");
  await ringsNFT.deployTransaction.wait(5);

  console.log("Verifying contract on GnosisScan...");
  try {
    await hre.run("verify:verify", {
      address: address,
      constructorArguments: [],
    });
    console.log("Contract verified successfully");
  } catch (error) {
    console.log("Verification failed:", error);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
  
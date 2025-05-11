async function main() {
    const [deployer] = await ethers.getSigners();
  
    console.log("Deploying contracts with the account:", deployer.address);
  
    const RingsNFT = await ethers.getContractFactory("RingsNFT");
    const ringsNFT = await RingsNFT.deploy("RingsNFT", "RNF");
  
    console.log("RingsNFT deployed to:", ringsNFT.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  
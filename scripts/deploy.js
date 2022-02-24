const main = async () => {
  const domainContractFactory = await hre.ethers.getContractFactory('Domains');
  const domainContract = await domainContractFactory.deploy("pns");
  await domainContract.deployed();

  console.log("Contract deployed to:", domainContract.address);

  
	let txn = await domainContract.register("atul",  {value: hre.ethers.utils.parseEther('0.1')});
	await txn.wait();
  console.log("Minted domain atul.pns");

  txn = await domainContract.setRecord("beep boop beep, it Works!");
  await txn.wait();
  console.log("Set record for atul.pns");

  const address = await domainContract.getAddress("atul");
  console.log("Owner of domain atul:", address);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
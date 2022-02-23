const main = async () => {
   
  const [owner, randomPerson] = await hre.ethers.getSigners();  
  const domainContractFactory = await hre.ethers.getContractFactory('Domains');
  const domainContract = await domainContractFactory.deploy("dob");
  await domainContract.deployed();
  console.log("Contract deployed to:", domainContract.address);
  console.log("Contract deployed by:", owner.address);

  let txn = await domainContract.register("test",  {value: hre.ethers.utils.parseEther('0.3')});  
  await txn.wait();

  const domainOwner = await domainContract.getAddress("test");
  console.log("Owner of domain:",domainOwner);

  const balance = await hre.ethers.provider.getBalance(domainContract.address);
  console.log("Contract balance:", hre.ethers.utils.formatEther(balance));
  
};

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

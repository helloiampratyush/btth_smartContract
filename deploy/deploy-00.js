const { network } = require("hardhat");
const { verify } = require("../utils/verify");

module.exports = async ({ deployments, getNamedAccounts }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
 
  
  const chainId =network.config.chainId;



  const contractName = await deploy("BtthGame", {
    from: deployer,
    log: true,
    args:[],
    waitConfirmations: network.config.blockConfirmations || 1,
  });
  console.log("deployments done");
  
  if (chainId != 31337) {
    console.log("here we are going to verify");
    await verify(contractName.address,[]);
    
  }
};
module.exports.tags = ["all", "BtthGame"];
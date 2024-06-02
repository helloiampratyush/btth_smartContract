const { network } = require("hardhat");
const { verify } = require("../utils/verify");

module.exports = async ({ deployments, getNamedAccounts }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
 
  
  const chainId =network.config.chainId


const args=(process.env.CHAINLINK_VRF)

  const contractName = await deploy("loginManagement", {
    from: deployer,
    log: true,
    args:[args],
    waitConfirmations: network.config.blockConfirmations || 1,
  });
  console.log("deployments done");
  
  if (chainId != 31337) {
    console.log("here we are going to verify");
    await verify(contractName.address,[args]);
    
  }
};
module.exports.tags = ["all", "login"];
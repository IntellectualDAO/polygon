const hre = require("hardhat");

/*

ENV Variables to set

HARDHAT_NETWORK: Sets the network to connect to.
HARDHAT_SHOW_STACK_TRACES: Enables JavaScript stack traces of expected errors.
HARDHAT_VERBOSE: Enables Hardhat verbose logging.
HARDHAT_MAX_MEMORY: Sets the maximum amount of memory that Hardhat can use.

*/

module.exports = async (name, symbol, getSignature) => {
    const {v, r, s} = await getSignature();
    const Intellectual = hre.ethers.getContractFactory("Intellectual");
    const intellectual = Intellectual.deploy(name, symbol, v, r, s);
    await intellectual.deployed();
    return intellectual;
}

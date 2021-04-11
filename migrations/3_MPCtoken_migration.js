const MPCToken = artifacts.require("MPCToken");
const cap = require('bignumber.js');
const cap_ = new cap(21000000000000000000);

module.exports = async function (deployer) {
  deployer.deploy(MPCToken, cap_);
};

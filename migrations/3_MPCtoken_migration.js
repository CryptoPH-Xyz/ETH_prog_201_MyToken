const MPCToken = artifacts.require("MPCToken");

module.exports = function (deployer) {
  var cap_ = 21000000;
  deployer.deploy(MPCToken, cap_);
};

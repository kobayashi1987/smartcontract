// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import { BagelToken } from "../../src/BagelToken.sol";
import { Test, console2 } from "forge-std/Test.sol";
import { console } from "forge-std/console.sol";
// import {DeployMerkleAirdrop} from "../../script/DeployMerkleAirdrop.s.sol";
// import {ZkSyncChainChecker} from "foundry-devops/src/ZkSyncChainChecker.sol";

contract MerkleAirdropTest is Test { 
    MerkleAirdrop public airdrop;
    BagelToken public token;
    bytes32 public ROOT = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    address user;
    uint256 userPrivateKey;

    function setUp() public {
        token = new BagelToken();
        airdrop = new MerkleAirdrop(ROOT, token);
        (user, userPrivateKey) = makeAddrAndKey("user");
    }
    function testUserCanClaim() public {
        console2.log("user address: ", user);
        uint256 startingBalance = token.balanceOf(user);

        vm.prank(user);

    }
}

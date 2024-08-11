// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {FundMe} from "../src/FundMe.sol";

import {Test, console} from "forge-std/Test.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run(); // DeployFundMe.run()
    }

    function testDemo() public pure {
        console.log("Hello, World!");
    }

    function testMinimumDollorIsFive() public view {
        console.log("Hello, theMinimumDollorIsFive!");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log("Hello, theOwnerIsMsgSender!");
        assertEq(fundMe.i_owner(), msg.sender);
    }

    // 1. Unit: Testing a single function
    // 2. Integration: Testing multiple functions
    // 3. Forked: Testing on a forked network
    // 4. Staging: Testing on a live network (testnet or mainnet)

    function testPriceFeedVersionIsAccurate() public view {
        console.log("Hello, thePriceFeedVersionIsAccurate!");
        assertEq(fundMe.getVersion(), 4);
    }
}

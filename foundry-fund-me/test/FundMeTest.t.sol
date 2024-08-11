// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {FundMe} from "../src/FundMe.sol";

import {Test, console} from "forge-std/Test.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        fundMe = new FundMe(address(0));
    }

    function testDemo() public pure {
        console.log("Hello, World!");
    }

    function theMinimumDollorIsFive() public view {
        console.log("Hello, theMinimumDollorIsFive!");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }
}

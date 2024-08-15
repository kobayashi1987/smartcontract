// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundMe} from "../../src/FundMe.sol";

import {Test, console} from "forge-std/Test.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract interactionsTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");

    uint256 public constant SEND_VALUE = 0.1 ether; // 100000000000000000 wei 1e17
    uint256 public constant STARTING_BALANCE = 1 ether; // 1000000000000000000 wei 1e18
    uint256 public constant GAS_PRICE = 1; // 1 Wei

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run(); // DeployFundMe.run()
        vm.deal(USER, STARTING_BALANCE);
    }

    function testDemo() public pure {
        console.log("Hello, World!");
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}

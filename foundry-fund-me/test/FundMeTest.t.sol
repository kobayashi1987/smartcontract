// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {DeployFundMe} from "../script/DeployFundMe.s.sol";
import {FundMe} from "../src/FundMe.sol";

import {Test, console} from "forge-std/Test.sol";

contract FundMeTest is Test {
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

    function testMinimumDollorIsFive() public view {
        console.log("Hello, theMinimumDollorIsFive!");
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        console.log("Hello, theOwnerIsMsgSender!");
        assertEq(fundMe.getOwner(), msg.sender);
    }

    // 1. Unit: Testing a single function
    // 2. Integration: Testing multiple functions
    // 3. Forked: Testing on a forked network
    // 4. Staging: Testing on a live network (testnet or mainnet)

    function testPriceFeedVersionIsAccurate() public view {
        console.log("Hello, thePriceFeedVersionIsAccurate!");
        assertEq(fundMe.getVersion(), 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        console.log("Hello, theFundFailsWithoutEnoughEth!");
        vm.expectRevert(); // the next line should revert
        // assert(This Tx should revert/fail);
        fundMe.fund(); // zero value
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER); // The next TX will be sent by USER
        console.log("Hello, theFundUpdatesFundedDataStructure!");

        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testAddsFunderToArrayOfFunders() public {
        vm.prank(USER); // The next TX will be sent by USER
        console.log("Hello, theAddsFunderToArrayOfFunders!");

        fundMe.fund{value: SEND_VALUE}();
        address funder = fundMe.getFunder(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        console.log("Hello, theOnlyOwnerCanWithdraw!");
        vm.prank(USER); // The next TX will be sent by USER
        vm.expectRevert(); // the next line should revert
        // assert(This Tx should revert/fail);
        fundMe.withdraw(); // zero value
    }

    function testWithdrawFromMultipleFunders() public funded {
        // Arrange

        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 2;
        for (
            uint160 i = startingFunderIndex;
            i < numberOfFunders + startingFunderIndex;
            i++
        ) {
            // we get hoax from stdcheats
            // prank + deal
            //fund the fundMe contract
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }

        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        // Act

        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        // Assert

        assert(address(fundMe).balance == 0);
        assert(
            startingFundMeBalance + startingOwnerBalance ==
                fundMe.getOwner().balance
        );
        // assert(
        //     (numberOfFunders + 1) * SEND_VALUE ==
        //         fundMe.getOwner().balance - startingOwnerBalance
        // );
    }

    function testWithdrawFromASingleFunder() public funded {
        // Arrange
        uint256 startingFundMeBalance = address(fundMe).balance;
        uint256 startingOwnerBalance = fundMe.getOwner().balance;

        // Act
        // vm.txGasPrice(GAS_PRICE);
        // uint256 gasStart = gasleft();
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        // uint256 gasEnd = gasleft();
        // uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        // console.log("Gas used: ", gasUsed);

        // Assert
        uint256 endingFundMeBalance = address(fundMe).balance;
        uint256 endingOwnerBalance = fundMe.getOwner().balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(
            startingFundMeBalance + startingOwnerBalance,
            endingOwnerBalance // + gasUsed
        );
    }
}

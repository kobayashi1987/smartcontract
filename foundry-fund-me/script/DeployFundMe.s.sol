// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {FundMe} from "../src/FundMe.sol";

contract DeployFundMe is Script {
    FundMe public fundMe;

    function setUp() public {}

    function run() external returns (FundMe) {
        // Anything before the Broadcast -> not a real TX
        HelperConfig helperConfig = new HelperConfig();
        // Anything after the Broadcast -> real TX

        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        // Mock

        fundMe = new FundMe(ethUsdPriceFeed);

        vm.stopBroadcast();

        return fundMe;
    }
}

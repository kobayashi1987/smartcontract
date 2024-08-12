// SPDX-License-Identifier: UNLICENSED

// 1. Deploy mocks when we are on a local anvil chain
// 2. Keep track of contract address acrooss different chains
// Sepolia ETH/USD
// Mainnet ETH/USD

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig {
    // if we are on a local anvil chain, deploy mocks
    // otherwise, grab the existing address from the live network

    struct NetworkConfig {
        address priceFeed;
    }

    function getSepoliaEthConfig() public pure {
        // price feed address
    }

    function getAnvilEthConfig() public pure {
        // price feed address
    }
}

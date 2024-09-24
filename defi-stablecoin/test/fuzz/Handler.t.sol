// Commented out for now until revert on fail == false per function customization is implemented

// // SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import { EnumerableSet } from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import { Test, console2 } from "forge-std/Test.sol";
// import { ERC20Mock } from "@openzeppelin/contracts/mocks/ERC20Mock.sol"; Updated mock location
import { ERC20Mock } from "../mocks/ERC20Mock.sol";

import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";
import { DSCEngine, AggregatorV3Interface } from "../../src/DSCEngine.sol";
import { DecentralizedStableCoin } from "../../src/DecentralizedStableCoin.sol";
// import {Randomish, EnumerableSet} from "../Randomish.sol"; // Randomish is not found in the codebase, EnumerableSet
// is imported from openzeppelin
import { MockV3Aggregator } from "../mocks/MockV3Aggregator.sol";
import { console } from "forge-std/console.sol";


contract Handler is Test {}
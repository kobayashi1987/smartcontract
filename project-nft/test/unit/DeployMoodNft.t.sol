// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() public view {
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPkhpISB5b3VyIGJyb3dzZXIgZGVjb2RlZCB0aGlzPC90ZXh0Pjwvc3ZnPg==";

        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="black">Hi! your browser decoded this</text></svg>';

        string memory actualUri = deployer.svgToImageURI(svg);

        console2.log("actualUri = ", actualUri);
        console2.log("expectedUri = ", expectedUri);

        assert(
            keccak256(abi.encodePacked(actualUri)) ==
                keccak256(abi.encodePacked(expectedUri))
        );

        // assertEq(actualUri, expectedUri);
    }
}

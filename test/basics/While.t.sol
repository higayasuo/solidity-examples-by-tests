// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract WhileTest is Test {
    function test_While() external {
        uint8 i = 0;
        bytes memory b;

        while (i < 5) {
            b = abi.encodePacked(b, i);
            i++;
        }
        assertEq(b, hex"0001020304");
    }

    function test_WhileBreak() external {
        uint8 i = 0;
        bytes memory b;

        while (i < 5) {
            if (i == 3) {
                break;
            }
            b = abi.encodePacked(b, i);
            i++;
        }
        assertEq(b, hex"000102");
    }

    function test_WhileContinue() external {
        uint8 i = 0;
        bytes memory b;

        while (i < 5) {
            if (i % 2 == 0) {
                continue;
            }
            b = abi.encodePacked(b, i);
            i++;
        }
        assertEq(b, hex"0103");
    }
}

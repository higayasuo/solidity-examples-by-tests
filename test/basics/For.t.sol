// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract ForTest is Test {
    function test_For() external {
        //uint8 i = 0;
        bytes memory b;

        for (uint8 i = 0; i < 5; i++) {
            b = abi.encodePacked(b, i);
        }
        assertEq(b, hex"0001020304");
    }

    function test_ForBreak() external {
        bytes memory b;

        for (uint8 i = 0; i < 5; i++) {
            if (i == 3) {
                break;
            }
            b = abi.encodePacked(b, i);
        }
        assertEq(b, hex"000102");
    }

    function test_ForContinue() external {
        bytes memory b;

        for (uint8 i = 0; i < 5; i++) {
            if (i % 2 == 0) {
                continue;
            }
            b = abi.encodePacked(b, i);
        }
        assertEq(b, hex"0103");
    }
}

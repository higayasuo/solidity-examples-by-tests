// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract BytesTest is Test {
    function test_FixedBytes() external {
        bytes3 b1 = "abc";
        bytes3 b2 = b1;
        //b2[1] = "d";
        b2 = "def";

        assertEq(b2, "def");
        assertEq(b1, "abc");
    }

    function test_DynamicBytes() external {
        bytes memory b1 = "abc";
        bytes memory b2 = b1;
        b2[1] = "d";

        assertEq(b2, "adc");
        assertEq(b1, "adc");
    }

    function test_Concat() external {
        bytes memory b1 = "abc" "def";
        assertEq(b1, "abcdef");
        assertEq(bytes.concat("abc", "def"), "abcdef");
    }

    function test_Compare() external pure {
        bytes memory b1 = "abc";
        //assert(b1 == "abc");
        assert(keccak256(b1) == keccak256("abc"));
    }

    function test_Length() external {
        bytes memory b1 = "abc";
        assertEq(b1.length, 3);
        //assertEq("abc".length, 3);
        assertEq(bytes("abc").length, 3);
    }
}

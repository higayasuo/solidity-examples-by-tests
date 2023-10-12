// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract StringTest is Test {
    function test_Concat() external {
        string memory str = "abc" "def";
        //assertEq("abc" "def", "abcdef");
        assertEq(str, "abcdef");
        assertEq(string.concat("abc", "def"), "abcdef");
    }

    function test_Compare() external pure {
        string memory str = "abc";
        //assert(str == "abc");
        assert(keccak256(bytes(str)) == keccak256("abc"));
    }

    function test_Unicode() external {
        //string memory str = "あ";
        string memory str = unicode"あ";
        assertEq(bytes(str).length, 3);
    }
}

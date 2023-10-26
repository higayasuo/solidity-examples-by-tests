// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract IfElseTest is Test {
    enum CompareResult {
        RightIsGreaterThanLeft,
        LeftIsGreaterThanRight,
        LeftAndRightAreEqual
    }

    function compare(uint256 left, uint256 right) private pure returns (CompareResult) {
        if (left < right) {
            return CompareResult.RightIsGreaterThanLeft;
        } else if (left > right) {
            return CompareResult.LeftIsGreaterThanRight;
        } else {
            return CompareResult.LeftAndRightAreEqual;
        }
    }

    function test_IfElse() external pure {
        assert(compare(1, 2) == CompareResult.RightIsGreaterThanLeft);
        assert(compare(2, 1) == CompareResult.LeftIsGreaterThanRight);
        assert(compare(1, 1) == CompareResult.LeftAndRightAreEqual);
    }
}

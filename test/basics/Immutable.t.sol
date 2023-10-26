// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract ImmutableTest is Test {
    //string immutable aaa;
    uint256 immutable max;

    constructor() {
        max = 10;
    }

    function getMax() public view returns (uint256) {
        return max;
    }

    function test_Immutable() external {
        assertEq(getMax(), 10);
        //MAX = 100;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract MathMoeTest is Test {
    // (x + y) % k
    function test_Addmod() external {
        assertEq(addmod(3, 4, 5), 2);
    }

    function test_Addmod_RevertIf_KisZero() external {
        vm.expectRevert();

        uint256 k = 0;
        addmod(3, 4, k);
    }

    // (x * y) % k
    function test_Mulmod() external {
        assertEq(mulmod(3, 4, 5), 2);
    }

    function test_Mulmod_RevertIf_KisZero() external {
        vm.expectRevert();

        uint256 k = 0;
        mulmod(3, 4, k);
    }
}

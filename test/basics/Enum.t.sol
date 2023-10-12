// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

enum MyEnum {
    One,
    Two,
    Three
}

contract EnumTest is Test {
    function test_ToUint256() external {
        assertEq(uint256(MyEnum.One), 0);
        assertEq(uint256(MyEnum.Two), 1);
        assertEq(uint256(MyEnum.Three), 2);
    }

    function test_Min() external pure {
        assert(type(MyEnum).min == MyEnum.One);
    }

    function test_Max() external pure {
        assert(type(MyEnum).max == MyEnum.Three);
    }
}

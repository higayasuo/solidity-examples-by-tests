// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Function {
    uint256 _value = 0;

    function add(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }

    function getValue() public view returns (uint256) {
        return _value;
    }

    function setValue(uint256 v) public {
        _value = v;
    }
}

contract FunctionTest is Test {
    Function _func;

    function setUp() public {
        _func = new Function();
    }

    function test_Add() public {
        assertEq(_func.add(1, 2), 3);
    }

    function test_GetValue() public {
        assertEq(_func.getValue(), 0);
    }

    function test_SetValue() public {
        _func.setValue(1);
        assertEq(_func.getValue(), 1);
    }
}

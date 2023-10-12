// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Scope {
    function scope1() external pure {
        {
            uint256 aaa;
            aaa = 1;
        }
        {
            uint256 aaa;
            aaa = 2;
        }
        //return aaa;
    }

    function scope2() external pure returns (uint256) {
        uint256 aaa;
        aaa = 1;
        {
            // uint256 aaa;
            // aaa = 2;
        }
        return aaa;
    }

    // function scope3() external pure {
    //     {
    //         aaa = 1;
    //         uint256 aaa;
    //     }
    // }
}

contract ScopeTest is Test {
    Scope _target;

    function setUp() external {
        _target = new Scope();
    }

    function test_Scope2() external {
        assertEq(_target.scope2(), 1);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract ConstantTest is Test {
    string constant CONST_STR = "aaa";

    function getConst() public pure returns (string memory) {
        return CONST_STR;
    }

    function test_Const() external {
        assertEq(getConst(), "aaa");
        //CONST_STR = "bbb";
    }
}

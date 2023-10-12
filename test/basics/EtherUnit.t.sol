// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract EtherUnitTest is Test {
    function test_Wei() external pure {
        //assertEq(1 wei, 1);
        assert(1 wei == 1);
    }

    function test_Gei() external pure {
        assert(1 gwei == 10 ** 9);
    }

    function test_Ether() external pure {
        assert(1 ether == 10 ** 18);
    }

    function test_Calc() external pure {
        assert(1 ether + 1 gwei + 1 wei + 1 == 10 ** 18 + 10 ** 9 + 2);
    }
}

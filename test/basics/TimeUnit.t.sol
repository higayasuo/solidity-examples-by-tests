// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract TimeUnitTest is Test {
    function test_Seconds() external pure {
        assert(1 seconds == 1);
    }

    function test_Menutes() external pure {
        assert(1 minutes == 60 seconds);
    }

    function test_Hours() external pure {
        assert(1 hours == 60 minutes);
    }

    function test_Days() external pure {
        assert(1 days == 24 hours);
    }

    function test_Weeks() external pure {
        assert(1 weeks == 7 days);
    }

    function test_Calc() external pure {
        assert(1 minutes + 1 seconds == 61);
    }
}

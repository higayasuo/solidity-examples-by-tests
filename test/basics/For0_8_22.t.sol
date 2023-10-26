// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Test.sol";

contract ForTest is Test {
    function test_ForUint256() external pure {
        for (uint256 i = 0; i < 1000; i++) {}
    }

    function test_ForUint256_prefix() external pure {
        for (uint256 i = 0; i < 1000; ++i) {}
    }

    function test_ForUint256_j() external pure {
        for (uint256 j = 0; j < 1000; j++) {}
    }

    function test_ForUint128() external pure {
        for (uint128 i = 0; i < 1000; i++) {}
    }

    function test_ForUint64() external pure {
        for (uint64 i = 0; i < 1000; i++) {}
    }

    function test_ForUint32() external pure {
        for (uint32 i = 0; i < 1000; i++) {}
    }

    function test_ForUint16() external pure {
        for (uint16 i = 0; i < 1000; i++) {}
    }

    function test_ForLe() external pure {
        for (uint256 i = 0; i <= 999; i++) {}
    }

    function test_ForNoPlusPlus() external pure {
        for (uint256 i = 0; i < 1000; i += 1) {}
    }

    function test_ForUnchecked() external pure {
        for (uint256 i = 0; i < 1000;) {
            unchecked {
                i++;
            }
        }
    }

    function test_ForUnchecked_j() external pure {
        for (uint256 j = 0; j < 1000;) {
            unchecked {
                j++;
            }
        }
    }

    function test_ForUncheckedLe() external pure {
        for (uint256 i = 0; i <= 999;) {
            unchecked {
                i++;
            }
        }
    }
}

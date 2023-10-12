// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Exception {
    error MyError(uint256 aaa, string bbb, bool ccc);
}

contract TryCatchTest is Test {
    error MyError(uint256 aaa, string bbb, bool ccc);

    function requireError() external pure {
        require(1 == 2, "error");
    }

    function test_RequireError() external {
        try this.requireError() {}
        catch Error(string memory reason) {
            assertEq(reason, "error");
        }
    }

    function revertString() external pure {
        revert("error");
    }

    function test_RevertString() external {
        try this.revertString() {}
        catch Error(string memory reason) {
            assertEq(reason, "error");
        }
    }

    function assertError() external pure {
        assert(1 == 2);
    }

    function test_AssertError() external {
        try this.assertError() {}
        catch Panic(uint256 errorCode) {
            assertEq(errorCode, 1);
        }
    }

    function divZeroError() external pure {
        uint256 a = 5;
        uint256 b = 0;

        a / b;
    }

    function test_DivZeroError() external {
        try this.divZeroError() {}
        catch Panic(uint256 errorCode) {
            assertEq(errorCode, 18);
        }
    }

    function uncheckedDivZeroError() external pure {
        uint256 a = 5;
        uint256 b = 0;

        unchecked {
            a / b;
        }
    }

    function test_UncheckedDivZeroError() external {
        try this.uncheckedDivZeroError() {}
        catch Panic(uint256 errorCode) {
            assertEq(errorCode, 18);
        }
    }

    function customError() external pure {
        revert MyError(1, "error", false);
    }

    function parseLowlevelData(bytes calldata data) external pure returns (bytes4, bytes memory) {
        return (bytes4(data), data[4:]);
    }

    function test_CustomError() external {
        try this.customError() {}
        catch (bytes memory lowlevelData) {
            assertEq(lowlevelData, abi.encodeWithSelector(Exception.MyError.selector, 1, "error", false));

            (bytes4 selector, bytes memory data) = this.parseLowlevelData(lowlevelData);
            (uint256 aaa, string memory bbb, bool ccc) = abi.decode(data, (uint256, string, bool));

            assertEq(selector, Exception.MyError.selector);
            assertEq(aaa, 1);
            assertEq(bbb, "error");
            assertEq(ccc, false);
        }
    }
}

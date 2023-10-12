// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract ReturnMultipleValues {
    function returnMultiplueValues() public pure returns (uint256, string memory, bool) {
        return (1, "xxx", true);
    }

    function returnArray() public pure returns (uint8[3] memory) {
        return [1, 2, 3];
    }

    function returnNamedValues() public pure returns (uint256 aaa, string memory bbb, bool ccc) {
        aaa = 1;
        bbb = "xxx";
        ccc = true;
    }
}

contract ReturnMultipleValuesTest is Test {
    ReturnMultipleValues _target;

    function setUp() public {
        _target = new ReturnMultipleValues();
    }

    function test_ReturnMultipleValues() public {
        (uint256 aaa, string memory bbb, bool ccc) = _target.returnMultiplueValues();
        assertEq(aaa, 1);
        assertEq(bbb, "xxx");
        assertEq(ccc, true);

        (uint256 ddd,, bool eee) = _target.returnMultiplueValues();
        assertEq(ddd, 1);
        assertEq(eee, true);

        (,, bool fff) = _target.returnMultiplueValues();
        assertEq(fff, true);

        (uint256 ggg,,) = _target.returnMultiplueValues();
        assertEq(ggg, 1);
    }

    function test_ReturnArray() public {
        uint8[3] memory ret = _target.returnArray();
        assertEq(ret[0], 1);
        assertEq(ret[1], 2);
        assertEq(ret[2], 3);
    }

    function test_ReturnNamedValues() public {
        (uint256 aa, string memory bb, bool cc) = _target.returnNamedValues();
        assertEq(aa, 1);
        assertEq(bb, "xxx");
        assertEq(cc, true);
    }
}

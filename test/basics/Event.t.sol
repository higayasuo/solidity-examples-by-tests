// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract EventTest is Test {
    event MyEvent(uint256 indexed aaa, string indexed bbb, bool ccc, bytes ddd);

    function test_GetRecordedLogs() external {
        vm.recordLogs();

        emit MyEvent(1, "bbb", true, "ddd");

        Vm.Log[] memory entries = vm.getRecordedLogs();

        assertEq(entries.length, 1);

        assertEq(entries[0].topics.length, 3);
        assertEq(entries[0].topics[0], keccak256("MyEvent(uint256,string,bool,bytes)"));
        assertEq(entries[0].topics[0], MyEvent.selector);
        assertEq(entries[0].topics[1], bytes32(uint256(1)));
        assertEq(entries[0].topics[2], keccak256(abi.encodePacked("bbb")));

        (bool ccc, bytes memory ddd) = abi.decode(entries[0].data, (bool, bytes));
        assertEq(ccc, true);
        assertEq(ddd, "ddd");
    }
}

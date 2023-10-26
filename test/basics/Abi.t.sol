// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract Adder {
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}

contract AbiTest is Test {
    struct Aaa {
        string name;
    }

    function test_EncodePacked() external {
        bytes memory result = abi.encodePacked(uint8(1), uint16(2));
        assertEq(result, hex"010002");
        assertEq(result.length, 3);
    }

    function test_Encode() external {
        bytes memory result = abi.encode(uint8(1), uint16(2));
        assertEq(
            result,
            hex"00000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000002"
        );
        assertEq(result.length, 64);
    }

    function test_EncodeWithSignature() external {
        Adder adder = new Adder();
        bytes memory data = abi.encodeWithSignature("add(uint256,uint256)", 1, 2);
        (bool success, bytes memory result) = address(adder).call(data);
        assertEq(success, true);
        assertEq(abi.decode(result, (uint256)), 3);
    }

    function test_EncodeWithSelector() external {
        Adder adder = new Adder();
        bytes4 selector = bytes4(keccak256("add(uint256,uint256)"));
        bytes memory data = abi.encodeWithSelector(selector, 1, 2);
        (bool success, bytes memory result) = address(adder).call(data);
        assertEq(success, true);
        assertEq(abi.decode(result, (uint256)), 3);
    }

    function test_EncodeWithSelector2() external {
        Adder adder = new Adder();
        bytes4 selector = Adder.add.selector;
        bytes memory data = abi.encodeWithSelector(selector, 1, 2);
        (bool success, bytes memory result) = address(adder).call(data);
        assertEq(success, true);
        assertEq(abi.decode(result, (uint256)), 3);
    }

    function test_Decode() external {
        Aaa memory aaa = Aaa("aaa");
        Adder adder = new Adder();

        bytes memory data = abi.encode(1, "hoge", aaa, adder);

        (uint256 a, string memory b, Aaa memory c, Adder d) = abi.decode(data, (uint256, string, Aaa, Adder));
        assertEq(a, 1);
        assertEq(b, "hoge");
        assertEq(c.name, "aaa");
        assertEq(d.add(1, 2), 3);
    }
}

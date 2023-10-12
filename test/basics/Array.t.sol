// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract Slicer {
    function sliceFrom(uint256[] calldata array, uint256 from) external pure returns (uint256[] memory) {
        return array[from:];
    }

    function sliceTo(uint256[] calldata array, uint256 to) external pure returns (uint256[] memory) {
        return array[:to];
    }

    function sliceFromTo(uint256[] calldata array, uint256 from, uint256 to) external pure returns (uint256[] memory) {
        return array[from:to];
    }
}

contract ArrayTest is Test {
    uint256[2] private fixedArray = [1, 2];
    uint256[] private extendableArray;
    Slicer private slicer = new Slicer();

    function test_FixedArray() external {
        //fixedArray.push(3);
        assertEq(fixedArray.length, 2);

        fixedArray[0] = 3;
        assertEq(fixedArray[0], 3);
    }

    function test_ExtendableArray() external {
        extendableArray.push(1);
        extendableArray.push(2);
        assertEq(extendableArray.length, 2);
        assertEq(extendableArray[0], 1);
        assertEq(extendableArray[1], 2);

        //uint256 u1 = extendableArray.pop();
        extendableArray.pop();
        assertEq(extendableArray.length, 1);
    }

    function test_MemoryArray() external {
        uint8[2] memory array = [1, 2];
        assertEq(array.length, 2);

        uint8[] memory array2 = new uint8[](2);
        //array2.push(3);
        //array2.pop();
        assert(array2[0] == 0);
        assert(array2[1] == 0);
    }

    function test_Slice() external {
        uint256[] memory array = new uint256[](5);
        array[0] = 1;
        array[1] = 2;
        array[2] = 3;
        array[3] = 4;
        array[4] = 5;

        uint256[] memory array2 = slicer.sliceFrom(array, 2);
        assertEq(array2.length, 3);
        assertEq(array2[0], 3);
        assertEq(array2[1], 4);
        assertEq(array2[2], 5);

        uint256[] memory array3 = slicer.sliceTo(array, 2);
        assertEq(array3.length, 2);
        assertEq(array3[0], 1);
        assertEq(array3[1], 2);

        uint256[] memory array4 = slicer.sliceFromTo(array, 1, 3);
        assertEq(array4.length, 2);
        assertEq(array4[0], 2);
        assertEq(array4[1], 3);
    }
}

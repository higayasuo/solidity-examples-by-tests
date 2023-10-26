// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

contract DataLocationTest is Test {
    string private storageStr = "aaa";
    string private storageStr2;
    uint8[] private storageUint8Array = [1, 2, 3];
    uint8[] private storageUint8Array2;

    function test_StorageToMemory() external {
        string memory memoryStr = storageStr;
        memoryStr = "AAA";

        assertEq(memoryStr, "AAA");
        assertEq(storageStr, "aaa");
    }

    function test_MemoryToStorage() external {
        string memory memoryStr = "AAA";
        storageStr = memoryStr;
        memoryStr = "a";

        assertEq(memoryStr, "a");
        assertEq(storageStr, "AAA");
    }

    function test_StorageToStorage() external {
        storageStr2 = storageStr;
        storageStr2 = "AAA";

        assertEq(storageStr2, "AAA");
        assertEq(storageStr, "aaa");

        storageUint8Array2 = storageUint8Array;
        storageUint8Array2[1] = 5;
        assertEq(storageUint8Array[0], 1);
        assertEq(storageUint8Array[1], 2);
        assertEq(storageUint8Array[2], 3);
        assertEq(storageUint8Array2[0], 1);
        assertEq(storageUint8Array2[1], 5);
        assertEq(storageUint8Array2[2], 3);
    }

    function test_StorageToLocalStorage() external {
        string storage localStorageStr = storageStr;
        storageStr = "AAA";
        //localStorageStr = "AAA";

        assertEq(localStorageStr, "AAA");
        assertEq(storageStr, "AAA");

        uint8[] storage localStorageUint8Array = storageUint8Array;
        localStorageUint8Array[1] = 5;
        assertEq(storageUint8Array[0], 1);
        assertEq(storageUint8Array[1], 5);
        assertEq(storageUint8Array[2], 3);
        assertEq(localStorageUint8Array[0], 1);
        assertEq(localStorageUint8Array[1], 5);
        assertEq(localStorageUint8Array[2], 3);

        //localStorageUint8Array = [1];
    }

    function test_MemoryToMemory() external {
        string memory str = "abc";
        string memory str2 = str;
        str2 = "def";
        //assertEq(str, "def");
        assertEq(str2, "def");

        uint8[2] memory array = [1, 2];
        uint8[2] memory array2 = array;
        array2[0] = 3;
        assertEq(array[0], 3);
        assertEq(array[1], 2);
        assertEq(array2[0], 3);
        assertEq(array2[1], 2);
    }

    function test_CalldataCannotModify(string calldata str) external {
        string calldata str2 = str;
        //str = "AAA";
        //str2 = "AAA";
        assertEq(str, str2);
    }

    function test_CalldataToMemory(string calldata str) external {
        string memory memoryStr = str;
        memoryStr = "AAA";

        assertEq(memoryStr, "AAA");
    }
}

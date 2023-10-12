// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";

contract FunctionCall {
    function publicFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function externalFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }

    function internalFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    function privateFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return a + b;
    }

    function withoutNameArgFunc(uint256 a, uint256 b, uint256) public pure returns (uint256) {
        return a + b;
    }

    function publicPublicFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return publicFunc(a, b);
    }

    // function publicExternalFunc(uint256 a, uint256 b) public pure returns (uint256) {
    //     return externalFunc(a, b);
    // }

    function publicExternalFunc2(uint256 a, uint256 b) public view returns (uint256) {
        return this.externalFunc(a, b);
    }

    function publicInternalFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return internalFunc(a, b);
    }

    function publicPrivateFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return privateFunc(a, b);
    }

    function externalPublicFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return publicFunc(a, b);
    }

    function externalInternalFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return internalFunc(a, b);
    }

    function externalPrivateFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return privateFunc(a, b);
    }

    function internalPublicFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return publicFunc(a, b);
    }

    function internalInternalFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return internalFunc(a, b);
    }

    function internalPrivateFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return privateFunc(a, b);
    }

    function privatePublicFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return publicFunc(a, b);
    }

    function privateInternalFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return internalFunc(a, b);
    }

    function privatePrivateFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return privateFunc(a, b);
    }
}

contract ChildFunctionCall is FunctionCall {
    function childPublicParentPublicFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return publicFunc(a, b);
    }

    function childPublicParentInternalFunc(uint256 a, uint256 b) public pure returns (uint256) {
        return internalFunc(a, b);
    }

    // function childPubliclParentPrivateFunc(uint256 a, uint256 b) public pure returns (uint256) {
    //     return privateFunc(a, b);
    // }

    function childExternalParentPublicFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return publicFunc(a, b);
    }

    function childExternalParentInternalFunc(uint256 a, uint256 b) external pure returns (uint256) {
        return internalFunc(a, b);
    }

    function childInternalParentPublicFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return publicFunc(a, b);
    }

    function childInternalParentInternalFunc(uint256 a, uint256 b) internal pure returns (uint256) {
        return internalFunc(a, b);
    }

    function childPrivateParentPublicFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return publicFunc(a, b);
    }

    function childPrivateParentInternalFunc(uint256 a, uint256 b) private pure returns (uint256) {
        return internalFunc(a, b);
    }
}

contract FunctionCallTest is Test {
    FunctionCall _target;
    ChildFunctionCall _child;

    function setUp() public {
        _target = new FunctionCall();
        _child = new ChildFunctionCall();
    }

    function test_PublicFunc() public {
        assertEq(_target.publicFunc(1, 2), 3);
    }

    function test_ExternalFunc() public {
        assertEq(_target.externalFunc(1, 2), 3);
    }

    // function test_InternalFunc() public {
    //     assertEq(_target.internalFunc(1, 2), 3);
    // }

    // function test_privateFunc() public {
    //     assertEq(_target.privateFunc(1, 2), 3);
    // }

    function test_WithoutNameArgFunc() public {
        assertEq(_target.withoutNameArgFunc(1, 2, 10), 3);
        //assertEq(_target.withoutNameArgFunc(1, 2), 3);
    }

    function test_PublicPublicFunc() public {
        assertEq(_target.publicPublicFunc(1, 2), 3);
    }

    function test_PublicExternalFunc() public {
        assertEq(_target.publicExternalFunc2(1, 2), 3);
    }

    function test_PublicInternalFunc() public {
        assertEq(_target.publicInternalFunc(1, 2), 3);
    }

    function test_PublicPrivateFunc() public {
        assertEq(_target.publicPrivateFunc(1, 2), 3);
    }

    function test_ExternalPublicFunc() public {
        assertEq(_target.externalPublicFunc(1, 2), 3);
    }

    function test_ExternalInternalFunc() public {
        assertEq(_target.externalInternalFunc(1, 2), 3);
    }

    function test_ExternalPrivateFunc() public {
        assertEq(_target.externalPrivateFunc(1, 2), 3);
    }

    function test_ChildPublicParentPublicFunc() public {
        assertEq(_child.childPublicParentPublicFunc(1, 2), 3);
    }

    function test_ChildPublicParentInternalFunc() public {
        assertEq(_child.childPublicParentInternalFunc(1, 2), 3);
    }

    function test_ChildExternalParentPublicFunc() public {
        assertEq(_child.childExternalParentPublicFunc(1, 2), 3);
    }

    function test_ChildExternalParentInternalFunc() public {
        assertEq(_child.childExternalParentInternalFunc(1, 2), 3);
    }
}

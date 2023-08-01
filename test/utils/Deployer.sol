// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import {Vm} from "lib/forge-std/src/Vm.sol";

uint256 constant wordSize = 0x20;

error CreateFailed();

function compile(Vm vm, string memory path) returns (bytes memory) {
    string[] memory cmd = new string[](2);
    cmd[0] = "vyper";
    cmd[1] = path;
    return vm.ffi(cmd);
}

function deploy(bytes memory initcode) returns (address deployment) {
    assembly {
        deployment := create(0, add(initcode, wordSize), mload(initcode))
    }
    if (deployment == address(0)) revert CreateFailed();
}

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract Keyboards {
    enum KeyboardKind {
        SixtyPercent,
        SeventyFivePercent,
        EightyPercent,
        Iso105
    }
    struct Keyboard {
        KeyboardKind kind;
        bool isPBT;
        string filter;
        address owner;
    }
    Keyboard[] public createdKeyboards;

    event KeyboardCreated(Keyboard keyboard);
    event TipSent(address recipient, uint256 amount);

    function getKeyboards() public view returns (Keyboard[] memory) {
        return createdKeyboards;
    }

    function create(
        KeyboardKind _kind,
        bool _isPBT,
        string calldata _filter
    ) external {
        Keyboard memory newKeyboard = Keyboard({
            kind: _kind,
            isPBT: _isPBT,
            filter: _filter,
            owner: msg.sender
        });

        createdKeyboards.push(newKeyboard);
        emit KeyboardCreated(newKeyboard);
    }

    function tip(uint256 _index) external payable {
        address payable owner = payable(createdKeyboards[_index].owner);
        owner.transfer(msg.value);
        emit TipSent(owner, msg.value);
    }
}

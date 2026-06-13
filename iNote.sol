// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract EncryptedNotes {
    struct Note {
        uint64 createdAt;
        bool   hidden;
        bytes  data;
    }

    uint256 public constant MAX_NOTE_BYTES = 8192;

    mapping(address => Note[]) private _notes;
    uint256 public totalNotes;

    event NoteCreated(address indexed author, uint256 indexed index, uint64 createdAt);
    event NoteHidden(address indexed author, uint256 indexed index);

    function createNote(bytes calldata data) external returns (uint256 index) {
        require(data.length > 0 && data.length <= MAX_NOTE_BYTES, "bad size");
        index = _notes[msg.sender].length;
        _notes[msg.sender].push(Note(uint64(block.timestamp), false, data));
        totalNotes++;
        emit NoteCreated(msg.sender, index, uint64(block.timestamp));
    }

    function hideNote(uint256 index) external {
        require(index < _notes[msg.sender].length, "no note");
        _notes[msg.sender][index].hidden = true;
        emit NoteHidden(msg.sender, index);
    }
}

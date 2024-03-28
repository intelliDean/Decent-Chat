// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ENS {

    string [] usernames;
    mapping(address => string) usernames;
    mapping(string => address) addresses;
    mapping(address => User) users;

    event Registered(address indexed user, string username);

    struct User {
        bytes32 userId;
        string username;
        address userAddress;
    }

    function register(string _username, uint256 _amount) external {
        checkUsername(_username);

        string memory name = abi.encodePacked(_username, ".eth");

        User storage _user = users[msg.sender];
        _user.username = name;
        _user.userAddress = msg.sender;
        _user.userId = keccak256(abi.encodePacked(msg.sender, _username));

        usernames[msg.sender] = name;
        addresses[name] = msg.sender;

        emit Registered(msg.sender, name);
    }

    function checkUsername(string _username) private {

        for (uint256 i; i < usernames.length; i++) {
           if (usernames[i] == _username) {
               revert USERNAME_NOT_AVAILABLE();
           }
        }
    }

}
error USERNAME_NOT_AVAILABLE();

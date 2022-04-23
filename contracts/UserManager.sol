// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract UserManager {
    struct User{
        string name;
        string age;
        string sex;
        string location;
    }

    User[] users;
	mapping (uint => address) validateUser;

    constructor() {
    }

    modifier onlyAllowed(uint _user_id){
        require(msg.sender == validateUser[_user_id] ,
        "Require user id to fetch details");
        _;
    }
	
	function _fetch(uint _user_id) public view onlyAllowed(_user_id) returns(User memory){
        return users[_user_id];
    }

	function _exists() public view returns(bool){
        if(users.length == 0) return false;

        return true;
    }
	
	function _fetchAll() public view returns(User[] memory){
        return users;
    }
	
    function _create(string memory _name, string memory _age,
                        string memory _sex, string memory _location) public {
        users.push(User(_name, _age, _sex, _location));
        uint id = users.length - 1;
        validateUser[id] = msg.sender;
    }    
}

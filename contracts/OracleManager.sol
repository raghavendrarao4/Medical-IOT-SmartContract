// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract OracleManager {
    struct Oracle{
        string owner;
        int completed;
        bool active;
        bool discoverable;
		string config;
    }

    Oracle[] oracles;
	mapping (uint => address) validateOracle;

    constructor() {
    }

    modifier onlyAllowed(uint _oracle_id){
        require(msg.sender == validateOracle[_oracle_id] ,
        "Require oracle id to fetch details");
        _;
    }
	
	function _fetchOracle(uint _oracle_id) public view onlyAllowed(_oracle_id) returns(Oracle memory){
        return oracles[_oracle_id];
    }

	function _exists() public view returns(bool){
        if(oracles.length == 0) return false;

        return true;
    }
	
	function _fetchAll() public view returns(Oracle[] memory){
        return oracles;
    }
	
    function _create(string memory _owner, int _completed,
                        bool _active, bool _discoverable, string memory _config) public {
        oracles.push(Oracle(_owner, _completed, _active, _discoverable, _config));
        uint id = oracles.length - 1;
        validateOracle[id] = msg.sender;
    }
	
	function toggleDiscoverable(uint _oracle_id, bool _discoverable) public {
        oracles[_oracle_id].discoverable = _discoverable;
    }
	
	function toggleActive(uint _oracle_id, bool _active) public {
        oracles[_oracle_id].active = _active;   
    }
	
	function updateConfig(uint _oracle_id, string memory _config) public {
        oracles[_oracle_id].config = _config;   
    }
}

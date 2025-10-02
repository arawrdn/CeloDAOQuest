// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DAOQuest {
    IERC20 public token; // CELO or cUSD
    address public owner;

    struct DAO {
        string name;
        address[] members;
        uint256 totalStake;
        uint256 successRate; // 0-100
    }

    struct Quest {
        string description;
        uint256 stakeRequired;
        bool completed;
        mapping(address => bool) voted;
    }

    DAO[] public daos;
    Quest[] public quests;

    constructor(address _token) {
        token = IERC20(_token);
        owner = msg.sender;
    }

    function createDAO(string memory name, address[] memory members) external {
        daos.push(DAO(name, members, 0, 0));
    }

    function participate(uint daoId, uint256 amount) external {
        DAO storage d = daos[daoId];
        require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        d.totalStake += amount;
        d.members.push(msg.sender);
    }

    function voteOnQuest(uint questId, uint daoId, bool vote) external {
        Quest storage q = quests[questId];
        require(!q.voted[msg.sender], "Already voted");
        q.voted[msg.sender] = true;
        // simplified: increase successRate if vote=true
        if(vote) {
            daos[daoId].successRate += 1;
        }
    }

    function resolveQuest(uint questId, uint daoId) external {
        Quest storage q = quests[questId];
        require(!q.completed, "Already completed");
        DAO storage d = daos[daoId];

        if(d.successRate >= (d.members.length / 2)) {
            // DAO succeeded
            for(uint i=0;i<d.members.length;i++){
                token.transfer(d.members[i], d.totalStake / d.members.length);
            }
        }
        q.completed = true;
    }

    function totalDAOs() external view returns(uint){
        return daos.length;
    }

    function totalQuests() external view returns(uint){
        return quests.length;
    }
}

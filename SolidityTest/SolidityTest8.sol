// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test8{
    /*
안건을 올리고 이에 대한 찬성과 반대를 할 수 있는 기능을 구현하세요. 
안건은 번호, 제목, 내용, 제안자(address) 그리고 찬성자 수와 반대자 수로 이루어져 있습니다.(구조체)
안건들을 모아놓은 자료구조도 구현하세요. 

사용자는 자신의 이름과 주소, 자신이 만든 안건 그리고 자신이 투표한 안건과 어떻게 투표했는지(찬/반)에 대한 정보[string => bool]로 이루어져 있습니다.(구조체)

* 사용자 등록 기능 - 사용자를 등록하는 기능
* 투표하는 기능 - 특정 안건에 대하여 투표하는 기능, 안건은 제목으로 검색, 이미 투표한 건에 대해서는 재투표 불가능
* 안건 제안 기능 - 자신이 원하는 안건을 제안하는 기능
* 제안한 안건 확인 기능 - 자신이 제안한 안건에 대한 현재 진행 상황 확인기능 - (번호, 제목, 내용, 찬반 반환 // 밑의 심화 문제 풀었다면 상태도 반환)
* 전체 안건 확인 기능 - 제목으로 안건을 검색하면 번호, 제목, 내용, 제안자, 찬반 수 모두를 반환하는 기능
-------------------------------------------------------------------------------------------------
* 안건 진행 과정 - 투표 진행중, 통과, 기각 상태를 구별하여 알려주고 전체의 70%가 투표에 참여하고 투표자의 66% 이상이 찬성해야 통과로 변경, 둘 중 하나라도 만족못하면 기각
*/
struct Proposal {
        uint id;
        string title;
        string content;
        address proposer;
        uint yesVotes;
        uint noVotes;
        uint totalVotes;
        ProposalStatus status;
    }

    struct User {
        string name;
        address userAddress;
        uint[] proposedProposals;
    }

    enum ProposalStatus { Voting, Passed, Rejected }

    mapping(address => User) public users;
    mapping(uint => Proposal) public proposals;
    mapping(address => mapping(uint => bool)) public hasVoted;
    
    uint public proposalCount;
    uint public userCount;

    function registerUser(string memory _name) public {
        users[msg.sender] = User(_name, msg.sender, new uint[](0));
        userCount++;
    }

    function createProposal(string memory _title, string memory _content) public {
        proposalCount++;
        proposals[proposalCount] = Proposal(
            proposalCount,
            _title,
            _content,
            msg.sender,
            0,
            0,
            0,
            ProposalStatus.Voting
        );
        users[msg.sender].proposedProposals.push(proposalCount);
    }

    function vote(uint _proposalId, bool _vote) public {
        require(!hasVoted[msg.sender][_proposalId], "Already voted");
      

        hasVoted[msg.sender][_proposalId] = true;

        if (_vote) {
            proposals[_proposalId].yesVotes++;
        } else {
            proposals[_proposalId].noVotes++;
        }
        proposals[_proposalId].totalVotes++;

        updateProposalStatus(_proposalId);
    }

    function updateProposalStatus(uint _proposalId) internal {
        Proposal storage proposal = proposals[_proposalId];
        if (proposal.totalVotes >= (userCount * 70 / 100)) {
            if (proposal.yesVotes >= (proposal.totalVotes * 66 / 100)) {
                proposal.status = ProposalStatus.Passed;
            } else {
                proposal.status = ProposalStatus.Rejected;
            }
        }
    }

    function getUserProposals() public view returns (Proposal[] memory) {
        uint[] memory userProposalIds = users[msg.sender].proposedProposals;
        Proposal[] memory userProposals = new Proposal[](userProposalIds.length);

        for (uint i = 0; i < userProposalIds.length; i++) {
            userProposals[i] = proposals[userProposalIds[i]];
        }

        return userProposals;
    }

    function getProposalByTitle(string memory _title) public view returns (Proposal memory) {
        for (uint i = 1; i <= proposalCount; i++) {
            if (keccak256(bytes(proposals[i].title)) == keccak256(bytes(_title))) {
                return proposals[i];
            }
        }
        revert("Proposal not found");
    }
}
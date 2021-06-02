pragma solidity ^0.5.16;

// contract Election{

//     // Store candidate
//     // Read candidate
//     string public candidate;
//     // Constructor
//     function getElection() public{

//         candidate = "Candidate 1";
//     }
// }


contract Election{

    // Model a Candidateac
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }
    // Store account that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate )public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor() public{
        addCandidate("Modi");
        addCandidate("Pappu");
    }

    function addCandidate (string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name ,0);
    }

    function vote (uint _candidateId) public {
        // require they havent voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount );
        
        // record that voter has voted
        voters[msg.sender] = true;
        // update candidate voteCount
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
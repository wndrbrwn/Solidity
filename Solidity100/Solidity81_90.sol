// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;

contract Q81 {
/*
Contract에 예치, 인출할 수 있는 기능을 구현하세요. 
지갑 주소를 입력했을 때 현재 예치액을 반환받는 기능도 구현하세요.  
*/
    mapping(address => uint) public deposits;

    function deposit() external payable {
        deposits[msg.sender] += msg.value;
    }

    function withdraw(uint amount) external {
        require(deposits[msg.sender] >= amount, "Insufficient balance");
        deposits[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getDeposit(address account) external view returns (uint) {
        return deposits[account];
    }
}

contract Q82 {
/*
특정 숫자를 입력했을 때 그 숫자까지의 3,5,8의 배수의 개수를 알려주는 함수를 구현하세요.
*/
    function countMultiples(uint num) external pure returns (uint count) {
        for (uint i = 1; i <= num; i++) {
            if (i % 3 == 0 || i % 5 == 0 || i % 8 == 0) {
                count++;
            }
        }
        return count;
    }
}

contract Q83 {
/*
이름, 번호, 지갑주소 그리고 숫자와 문자를 연결하는 mapping을 가진 구조체 사람을 구현하세요. 
사람이 들어가는 array를 구현하고 array안에 push 하는 함수를 구현하세요.
*/
    struct Person {
        string name;
        uint256 id;
        address walletAddress;
        string info;
    }

    Person[] public people;

    function addPerson(string memory _name, uint _id, address _walletAddress, string memory _info) external {
        Person memory newPerson = Person(_name, _id, _walletAddress, _info);
        people.push(newPerson);
    }
}

contract Q84 {
/*
2개의 숫자를 더하고, 빼고, 곱하는 함수들을 구현하세요. 
단, 이 모든 함수들은 blacklist에 든 지갑은 실행할 수 없게 제한을 걸어주세요.
*/
    address public blacklistOwner;
    mapping(address => bool) public blacklist;

    modifier notBlacklisted() {
        require(!blacklist[msg.sender], "Wallet is blacklisted");
        _;
    }

    constructor() {
        blacklistOwner = msg.sender;
    }

    function addBlacklist(address wallet) external {
        require(msg.sender == blacklistOwner, "Only owner can blacklist");
        blacklist[wallet] = true;
    }

    function add(uint a, uint b) external notBlacklisted returns (uint) {
        return a + b;
    }

    function subtract(uint a, uint b) external notBlacklisted returns (uint) {
        require(a >= b, "Subtraction underflow");
        return a - b;
    }

    function multiply(uint a, uint b) external notBlacklisted returns (uint) {
        return a * b;
    }
}

contract Q85 {
/*
숫자 변수 2개를 구현하세요. 한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다. 
찬성, 반대 투표는 배포된 후 20개 블록동안만 진행할 수 있게 해주세요.
*/
    address public owner;
    uint public forVotes;
    uint public againstVotes;
    uint public endBlock;

    bool public votingOpen = true;

    modifier onlyDuringVoting() {
        require(block.number <= endBlock && votingOpen, "Voting closed");
        _;
    }

    constructor() {
        endBlock = block.number + 20; 
    }

    function voteFor() external onlyDuringVoting {
        forVotes++;
    }

    function voteAgainst() external onlyDuringVoting {
        againstVotes++;
    }

    function closeVoting() external {
        require(msg.sender == owner, "Only owner can close voting");
        votingOpen = false;
    }
}

contract Q86 {
/*
숫자 변수 2개를 구현하세요. 한개는 찬성표 나머지 하나는 반대표의 숫자를 나타내는 변수입니다. 
찬성, 반대 투표는 1이더 이상 deposit한 사람만 할 수 있게 제한을 걸어주세요.
*/
    uint public forVotes;
    uint public againstVotes;

    mapping(address => uint) public deposits;

    modifier onlyWithDeposit(uint amount) {
        require(deposits[msg.sender] >= amount, "Insufficient deposit");
        _;
    }

    function deposit() external payable {
        deposits[msg.sender] += msg.value;
    }

    function voteFor() external onlyWithDeposit(1 ether) {
        forVotes++;
    }

    function voteAgainst() external onlyWithDeposit(1 ether) {
        againstVotes++;
    }
}

contract Q87 {
/*
visibility에 신경써서 구현하세요.   
숫자 변수 a를 선언하세요. 해당 변수는 컨트랙트 외부에서는 볼 수 없게 구현하세요. 
변화시키는 것도 오직 내부에서만 할 수 있게 해주세요.
*/
    uint private a;

    function getA() internal view returns (uint) {
        return a;
    }

    function setA(uint _a) internal {
        a = _a;
    }
}

contract OWNER {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function setInternal(address _a) internal {
        owner = _a;
    }

    function getOwner() public view returns(address) {
        return owner;
    }
}

contract Q88 is OWNER{
/*
아래의 코드를 보고 owner를 변경시키는 방법을 생각하여 구현하세요.

contract OWNER {
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    function setInternal(address _a) internal {
        owner = _a;
    }

    function getOwner() public view returns(address) {
        return owner;
    }
}
힌트 : 상속
*/
    string public someData;

    function setData(string memory _data) external {
        someData = _data;
    }

}

contract Q89 {
/*
이름과 자기 소개를 담은 고객이라는 구조체를 만드세요. 
이름은 5자에서 10자이내 자기 소개는 20자에서 50자 이내로 설정하세요. 
(띄어쓰기 포함 여부는 신경쓰지 않아도 됩니다. 더 쉬운 쪽으로 구현하세요.)
*/
    struct Customer {
        bytes5 name;
        bytes32 introduction;
    }

    function createCustomer(bytes5 _name, bytes32 _introduction) external {
        require(_name.length >= 5 && _name.length <= 10, "Name length invalid");
        require(_introduction.length >= 20 && _introduction.length <= 50, "Introduction length invalid");

        Customer memory newCustomer = Customer(_name, _introduction);
    }
}

contract Q90 {
/*
당신 지갑의 이름을 알려주세요. 아스키 코드를 이용하여 byte를 string으로 바꿔주세요.
*/
    function getWalletName() external pure returns (string memory) {
        bytes32 name = 0x596f757257616c6c65744e616d65;
        bytes memory nameBytes = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            nameBytes[i] = name[i];
        }
        return string(nameBytes);
    }
}
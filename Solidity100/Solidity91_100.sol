// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.8.2 < 0.9.0;


contract Q91 {
/*
배열에서 특정 요소를 없애는 함수를 구현하세요. 
예) [4,3,2,1,8] 3번째를 없애고 싶음 → [4,3,1,8]
*/
    uint[] public arr;

    function pushNum(uint _n) public {
        arr.push(_n);
    }

    function removeNum(uint index) public {
        require(index < arr.length, "Index out of bounds");

        for (uint i = index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }

    function getArray() public view returns (uint[] memory) {
        return arr;
    }
}

contract Q92 {
/*
특정 주소를 받았을 때, 그 주소가 EOA인지 CA인지 감지하는 함수를 구현하세요.
*/
    function AccountType(address account) public pure returns (string memory) {
        if (account == address(0)) {
            return "EOA";
        } else {
            return "CA";
        }
    }
}

contract Q93 {
/*
다른 컨트랙트의 함수를 사용해보려고 하는데, 그 함수의 이름은 모르고 methodId로 추정되는 값은 있다. 
input 값도 uint256 1개, address 1개로 추정될 때 해당 함수를 활용하는 함수를 구현하세요.
*/
    function call(address c_Address, bytes4 methodId, uint inputValue, address addrValue) public {
        (bool success, ) = c_Address.call(abi.encodeWithSelector(methodId, inputValue, addrValue));
        require(success, "nope");
    }
}

contract Q94 {
/*
inline - 더하기, 빼기, 곱하기, 나누기하는 함수를 구현하세요.
*/
 function add(uint a, uint b) public pure returns(uint sum) {
        assembly {
            sum := add(a, b)
        }
    }

    function sub(uint a, uint b) public pure returns(uint sum) {
        assembly {
            sum := sub(a, b)
        }
    }

    function mul(uint a, uint b) public pure returns(uint sum) {
        assembly {
            sum := mul(a, b)
        }
    }

    function div(uint a, uint b) public pure returns(uint sum) {
        assembly {
            sum := div(a, b)
        }
    }
}

contract Q95 {
/*
inline - 3개의 값을 받아서, 더하기, 곱하기한 결과를 반환하는 함수를 구현하세요.
*/
    function addAndMultiply(uint a, uint b, uint c) public pure returns (uint _add, uint _mul) {
        assembly {
            _add := add(add(a, b), c)
            _mul := mul(mul(a, b), c)
        }
    }
}

contract Q96 {
/*
inline - 4개의 숫자를 받아서 가장 큰수와 작은 수를 반환하는 함수를 구현하세요.
*/
    function findMinMax(uint a, uint b, uint c, uint d) public pure returns (uint max, uint min) {
        assembly {
            max := a
            if gt(b, max) {
                max := b
            }
            if gt(c, max) {
                max := c
            }
            if gt(d, max) {
                max := d
            }

            min := a
            if lt(b, min) {
                min := b
            }
            if lt(c, min) {
                min := c
            }
            if lt(d, min) {
                min := d
            }
        }
    }
}

contract Q97 {
/*
inline - 상태변수 숫자만 들어가는 동적 array numbers에 push하고 pop하는 함수 그리고 전체를 반환하는 구현하세요.
*/
    uint[] public numbers;

    function pushAndPop(uint value) public {
        assembly {
            let len := sload(numbers.slot)
            sstore(numbers.slot, add(len, 1))
            sstore(add(numbers.slot, mul(add(len, 1), 0x20)), value)
        }
    }

    function pop() public returns (uint) {
        require(numbers.length > 0, "Array is empty");
        uint value;
        assembly {
            let len := sload(numbers.slot)
            if gt(len, 0) {
                value := sload(add(numbers.slot, mul(len, 0x20)))
                sstore(numbers.slot, sub(len, 1))
            }
        }

        return value;
    }

    function getArray() public view returns (uint[] memory) {
        return numbers;
    }
}

contract Q98 {
/*
inline - 상태변수 문자형 letter에 값을 넣는 함수 setLetter를 구현하세요.
*/
    string public letter;

    function setLetter(string memory _a) public {
        bytes memory a_Bytes = bytes(_a);
        require(a_Bytes.length > 0, "nope");

        assembly {
            // 상태 변수 `letter`의 슬롯을 계산하여 저장
            sstore(0x01, add(_a, 0x20))
        }

        letter = _a;
    }
}

contract Q99 {
/*
inline - bytes4형 b의 값을 정하는 함수 setB를 구현하세요.
*/
    function setB(bytes4 value) public pure returns (bytes4) {
        bytes4 b;
        
        assembly {
            b := value
        }
        
        return b;
    }
}

contract Q100 {
/*
inline - bytes형 변수 b의 값을 정하는 함수 setB를 구현하세요.
*/
    function setB(bytes memory value) public pure returns (bytes memory) {
        bytes memory b = new bytes(value.length);
        
        assembly {
            let Ptr := add(value, 0x20)
            let bPtr := add(b, 0x20)
            let length := mload(value)
            for { let i := 0 } lt(i, length) { i := add(i, 0x20) } {
                mstore(add(bPtr, i), mload(add(Ptr, i)))
            }
        }
        
        return b;
    }
}
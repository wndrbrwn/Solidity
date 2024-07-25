// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;

contract Test9{
/*
흔히들 비밀번호 만들 때 대소문자 숫자가 각각 1개씩은 포함되어 있어야 한다 
등의 조건이 붙는 경우가 있습니다. 그러한 조건을 구현하세요.

입력값을 받으면 그 입력값 안에 대문자, 
소문자 그리고 숫자가 최소한 1개씩은 포함되어 있는지 여부를 
알려주는 함수를 구현하세요.
*/
function Password(string memory password) public pure returns (bool) {
        bytes memory passwordBytes = bytes(password);
        bool Uppercase;
        bool Lowercase;
        bool Number;
        bool Special;

        for (uint i = 0; i < passwordBytes.length; i++) {
            bytes1 char = passwordBytes[i];
            
            //최소 8자리 검사 추가
            if (passwordBytes.length < 8) {
            return false;
        }   
            
            if (char >= 0x41 && char <= 0x5A) {
                Uppercase = true;
            } else if (char >= 0x61 && char <= 0x7A) {
                Lowercase = true;
            } else if (char >= 0x30 && char <= 0x39) {
                Number = true;
            } 
            //특수문자 검사 추가
            else if ((char >= 0x21 && char <= 0x2F) || 
                       (char >= 0x3A && char <= 0x40) || 
                       (char >= 0x5B && char <= 0x60) || 
                       (char >= 0x7B && char <= 0x7E)) {
                Special = true;
            } 
            if (Uppercase && Lowercase && Number && Special) {
                return true;
            }
        }

        return false;
    }

//다른 방식 추가
function Password2(string memory password) public pure returns (bool) {
        bytes memory passwordBytes = bytes(password);
        uint flag;
        uint length = passwordBytes.length;
         
         if (passwordBytes.length < 8) {
            return false;
        }

        for (uint i = 0; i < length; i++) {
            bytes1 char = passwordBytes[i];
            
            if (char >= 0x41 && char <= 0x5A) {
                flag |= 0x1;
            } else if (char >= 0x61 && char <= 0x7A) {
                flag |= 0x2;
            } else if (char >= 0x30 && char <= 0x39) {
                flag |= 0x4;
            } else if ((char >= 0x21 && char <= 0x2F) || 
                       (char >= 0x3A && char <= 0x40) || 
                       (char >= 0x5B && char <= 0x60) || 
                       (char >= 0x7B && char <= 0x7E)) {
                flag |= 0x8; 
            }

            if (flag == 0xF) {
                return true;
            }
        }

        return false;
    }
}    

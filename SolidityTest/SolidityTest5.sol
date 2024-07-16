// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 < 0.9.0;


contract Test5 {
/*
숫자를 시분초로 변환하세요.
예) 100 -> 1 min 40 sec
600 -> 10min 
1000 -> 16min 40sec
5250 -> 1hour 27min 30sec
*/
function convertSeconds(uint secondsInput) public pure returns (string memory) {
        uint hoursCount = secondsInput / 3600;
        uint minutesCount = (secondsInput % 3600) / 60;
        uint secondsCount = secondsInput % 60;
        
        string memory result = "";
        
        if (hoursCount > 0) {
            result = string(abi.encodePacked(str(hoursCount), " hour "));
        }
        if (minutesCount > 0 || hoursCount > 0) {
            result = string(abi.encodePacked(result, str(minutesCount), " min "));
        }
        result = string(abi.encodePacked(result, str(secondsCount), " sec"));
        
        return result;
    }
    
    function str(uint _i) internal pure returns (string memory) {
        if (_i == 0) return "0";
        
        uint j = _i;
        uint length;
        for (length = 0; j != 0; length++) {
            j /= 10;
        }
        
        bytes memory bstr = new bytes(length);
        for (uint k = length; _i != 0; k--) {
            bstr[k-1] = bytes1(uint8(48 + _i % 10));
            _i /= 10;
        }
        
        return string(bstr);
    }
}
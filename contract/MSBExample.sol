
// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;
contract MSBExample{

    uint public constant MAX_UINT = type(uint).max;
    // MSB函数：使⽤Solidity实现 --2430 gas 
    function msbResult(uint256 x) public pure returns (uint256) {
        uint256 msb = 0;
        if (x >= 2**128) { x >>= 128; msb += 128; }
        if (x >= 2**64) { x >>= 64; msb += 64; }
        if (x >= 2**32) { x >>= 32; msb += 32; }
        if (x >= 2**16) { x >>= 16; msb += 16; }
        if (x >= 2**8) { x >>= 8; msb += 8; }
        if (x >= 2**4) { x >>= 4; msb += 4; }
        if (x >= 2) { x >>= 2; msb += 2; }
        if (x >= 1) { msb += 1; }
        return msb;
    }

    // MSB函数：使⽤汇编语⾔优化 --1060 gas
    function msbOptimized(uint256 x) public pure returns (uint256) {
         uint256 msb;

         assembly {
            // ⽐较和位移操作的汇编实现
            if gt(x, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {
                x := shr(128, x)
                msb := add(msb, 128)
            }

            if gt(x, 0xFFFFFFFFFFFFFFFF) {
                x := shr(64, x)
                msb := add(msb, 64)
            }

            if gt(x, 0xFFFFFFFF) {
                x := shr(32, x)
                msb := add(msb, 32)
            }

            if gt(x, 0xFFFF) {
                x := shr(16, x)
                msb := add(msb, 16)
            }

            if gt(x, 0xFF) {
                x := shr(8, x)
                msb := add(msb, 8)
            }
            if gt(x, 0xF) {
                x := shr(4, x)
                msb := add(msb, 4)
            }
            if gt(x, 0x3) {
                x := shr(2, x)
                msb := add(msb, 2)
            }
            if gt(x, 0x1) {
                 msb := add(msb, 1)
            }
         
         }
         return msb;
    
    }



    // MSB函数：使⽤汇编语⾔优化--947 gas  理解使⽤汇编语⾔优化Solidity代码的优势
    function mostSignificantBit(uint256 x) external pure returns (uint256 r){
        // ⽐较和位移操作的汇编实现
        assembly {
            let f := shl(7, gt(x, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF))
            x := shr(f, x)
            // or can be replaced with add
            r := or(r, f)
        }

        assembly {
            let f := shl(6, gt(x, 0xFFFFFFFFFFFFFFFF))
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(5, gt(x, 0xFFFFFFFF))
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(4, gt(x, 0xFFFF))
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(3, gt(x, 0xFF))
            x := shr(f, x)
            r := or(r, f)
        }
        
        assembly {
            let f := shl(2, gt(x, 0xF))
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := shl(1, gt(x, 0x3))
            x := shr(f, x)
            r := or(r, f)
        }

        assembly {
            let f := gt(x, 0x1)
            r := or(r, f)
        }


    }

}
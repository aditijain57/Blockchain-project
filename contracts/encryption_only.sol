// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "elliptic-curve-solidity/contracts/EllipticCurve.sol";
//import "./Access_Control_Contract.sol";

//for Encrpytion-decryption only.
//simple example of caesar cipher
contract EncryptionOnly{
        
        
         struct KeyInfo{
              
              uint para;
              uint a;
              uint d;
              uint b;
          }
          KeyInfo keyInfo;
          //since random generation of numbers is not available
          //using timestamp to generate a key
          uint w = block.timestamp;
          function genRand_MasterKey() public view returns(uint _gen_rand){
              _gen_rand= (w*w + w) % 10000000000 ; //10 digit key
              return _gen_rand; 
          }
          
          //Encryption takes the data, puts it in a bytes array and calls for encryptByte 
          //takes the input converts it back into string and returns value
          function encrypt(uint key, string memory s_text)pure public returns(string memory _cipher){
              bytes memory text = bytes(s_text);
              uint i =0; //for key 
              uint j =0; //for text
              uint n =10;
              uint[] memory key_array = new uint[](n);
              for(uint q =0; q < n; q++){
                 key_array[n-1 - q] = uint(key % 10);
              }
                           
              while (j < text.length){
                  if(i <= key_array.length){
                      text[j] = encryptByte(text[j],key_array[i]);
                      j++;
                      i++;
                  }
                  else
                      i=0https://github.com/aditijain57/Graph-Coloring.git
              }
              return string(text);
          }
          //Since string manipulation is not available in solidity
          //convert into uint8 from bytes, apply the key, create cipher text 
          //convert back into byte and return value
          function encryptByte(byte b, uint k) pure internal returns(byte){
              uint8 ascii = uint8(b);
              uint8 asciiShift;
              uint8 ans;
        
              if (ascii >= 65 && ascii <= 90)
                asciiShift = 65;
              else if (ascii >= 97 && ascii <=122)
                asciiShift = 97;
              else if (ascii == 32)
                ans = 32;
                
              ans = uint8(((ascii + asciiShift + k + 26) % 26) + asciiShift);
        
              return byte(ans);
          }
          //similarly with decryption
          function decrypt(string memory s_cipher, uint key) pure public returns (string memory _text) {
              bytes memory cipher = bytes(s_cipher);
              uint i =0; //for key 
              uint j =0; //for text
              uint n =10;
              uint[] memory key_array = new uint[](n);
              for(uint q =0; q < n; q++){
                  key_array[n-1 - q] = uint(key % 10);
              }
                
              while (j < cipher.length){
                  if(i <= key_array.length){
                      cipher[j] = decryptByte(cipher[j],key_array[i]);
                      j++;
                      i++;
                  }
                  else
                      i=0;
              }
              return string(cipher);
            }
    
          function decryptByte(byte b, uint k) pure internal returns (byte) {
              uint8 ascii = uint8(b);
              uint8 asciiShift;
              uint8 ans;
        
              if (ascii >= 65 && ascii <= 90)
                asciiShift = 65;
              else if (ascii >= 97 && ascii <=122)
                asciiShift = 97;
              else if (ascii == 32)
                ans = 32;
                
              ans = uint8(((ascii - asciiShift - k + 26) % 26) + asciiShift);
        
              return byte(ans);
            }
            
            //function encryptKey(uint smkey) pure internal returns(uint _enSMK){}
        
}

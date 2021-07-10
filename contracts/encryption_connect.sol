// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.6.12;

import "elliptic-curve-solidity/contracts/EllipticCurve.sol";
import "./EncryptionOnly.sol";
import "./Access_Control_Contract.sol";

// for connector functions onlyOwner
//encryption and decryption are PReV1

contract EncryptionConnection {
    
    struct KeyInfo{
        
          uint SMkey;
          uint encKey;
          string record;
          string query_link;
      }
      
    address private owner;
    mapping (address => KeyInfo) public patients; 
    mapping (address => KeyInfo) private providers;
    mapping (address => KeyInfo) private oth_providers;
    
      //Access_Control_Contract.ownership owner_ = Access_Control_Contract.ownership.owner;
      //uint key_owner = calSMK();
      
      modifier onlyOwner() {
        require(msg.sender == owner);
        _;
      }
      
      //SMkey = EncryptionOnly.genRand_MasterKey();
      
      function keyForUser(address usr) public payable returns(uint){
          if(usr == patients){
              patients.SMkey = EncryptionOnly.genRand_MasterKey();
              patients.encKey = EncryptionOnly.encryptKey(patients.SMkey);
              return patients.encKey;
          }
          if(usr == providers){
              providers.SMkey = EncryptionOnly.genRand_MasterKey();
              providers.encKey = EncryptionOnly.encryptKey(providers.SMkey);
              return providers.encKey;
          }
          if(usr == oth_providers){
              //patients.SMkey = EncryptionOnly.genRand_MasterKey();
              //patients.encKey = EncryptionOnly.encryptKey(patients.SMkey);
              return keyInfo.encKey;
          }
      }
      
      function encryptWithSMK(uint smkey, string _record, string _ql) public view returns(string en_record, string en_ql){
          uint _record1 = EncryptionOnly.encrypt(smkey, _record);
          uint _ql1 = EncryptionOnly.encrypt(smkey, _ql);
          return(_record1,_ql1);
      }
      
      function checkAccess(address usr) public view returns(uint key){
          bool ck1 = Access_Control_Contract.isReadQualified(usr);
          return patients.encKey;
      }
      
      function forwardKeys(address usr) public view onlyOwner returns(uint, uint) {
          if(usr==patients){
              return (patients.encKey, patients.SMkey);
          }
          if(usr==providers){
              return (providers.encKey, providers.SMkey);
          }
          
      }
      function sendToDB(address usr, string _record, string _ql) public view returns(uint, uint, string, string){
           require(usr==patients)
              (patients.record, patients.query_link) = encryptWithSMK(_record, _ql);
              return (patients.encKey, patients.SMkey, patients.record, patients.query_link);
          }
}

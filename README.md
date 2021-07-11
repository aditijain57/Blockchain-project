# Blockchain-project
These smart contracts are part of my project-internship.

Voting Proposal and Crowd Funding contracts
A crowdfunding platform is needed to be designed for a scenario where there are three different voting proposals among which the highest voted proposal will be selected as the best proposal for which funding is to be raised. Three domains for voting proposals can be the IT sector, agriculture, and medical/healthcare domain. The design of the platform will include two smart contracts in the Remix environment employing solidity language. One will be a voting proposal which gives the decision of the highest voted proposal which will be called the best proposal. The other contract will be a funding proposal to raise the funds for the best proposal given by the voting proposal.


Access Control Contract
This contract is part of another project called Medchain : A Design of Blockchain-Based System for Electronic Medical Records(EMRs) Access and Permissions Management {Digital Object Identifier 10.1109/ACCESS.2019.2952942} - access system for a blockchain network consisting various health providers who simultaneously treat the same individuals and constantly need complete patient data. Hence using blockchain in a way to efficiently share EMRs keeping the privacy of the patients safe.  
It comprises of the permissions available for accessing the sensitive information of the patients and which groups should be given what kind of access.
For example, patients can only read their own record’s content, they must not have the right to view someone else’s records nor must they be able to change any information on their own. Similarly, third party access must be a blind read of the EMR to preserve patients’ right to privacy.
These permissions are given to the access groups and based on these permissions their content encryption level is decided.

Encryption-only Contract
Also part of the Medchain project where after assigning permissions, we add the encryption layer. The encryption part consists of 2 contracts- encryption-only and encryption-connection. 
This contract is made to carry functions for encryption/ decryption, master-key generation for symmetric encryption. This division helps in better implementation of the code. It is inherited and imported so that its functions are used by Encryption -Connection Contract which acts as the base contract to interact with other smart contracts, javascript platform and the database.

Encryption-connection Contract
This contract focuses on connecting this smart contract with other smart contracts. It has functions that give requested encrypted/decrypted information to contracts like PRC, NCC, LC and saves the key information into the database as well. This contracts imports and inherits the Encryption-Only Contract.


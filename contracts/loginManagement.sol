//SPDX-License-Identifier:MIT
pragma solidity 0.8.20;

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

     contract loginManagement is VRFConsumerBaseV2Plus{
        address vrfCoordinator = 0x343300b5d84D444B2ADc9116FEF1bED02BE49Cf2;
        bytes32 keyHash =0x816bedba8a50b294e5cbd47842baf240c2385f2eaf719edbd4f250a137a8c899;
        uint32 callbackGasLimit = 2500000;
        uint16 requestConfirmations = 3;
        uint32 numWords =  1;
        //subscription id

        // Your subscription ID.
        uint256 public s_subscriptionId;
         constructor(uint256 subscriptionId)
         VRFConsumerBaseV2Plus(vrfCoordinator) {
            s_subscriptionId=subscriptionId;
         }
       // struct variable
         struct login{
            uint256 s_lastTimestamp;
             bool   used;
            uint256 s_lastRequestId;
            uint256 s_lastResulted;
            } 
        // vrf status checker
            struct RequestStatus {
            bool fulfilled; // whether the request has been successfully fulfilled
            bool exists; // whether a requestId exists
            uint256 randomWords;
        }

            //mapping
        mapping(address=>login) public loginMap;
        mapping(uint256=>address) public requestToAddresslogin;
        mapping(uint256 => RequestStatus) public s_requests;

        //mapping
         function startLogin() public returns(uint256 requestId){
            require(block.timestamp-loginMap[msg.sender].s_lastTimestamp>=24*3600,"login later");
             requestId = s_vrfCoordinator.requestRandomWords(
             VRFV2PlusClient.RandomWordsRequest({
                keyHash: keyHash,
                subId: s_subscriptionId,
                requestConfirmations: requestConfirmations,
                callbackGasLimit: callbackGasLimit,
                numWords: numWords,
                extraArgs: VRFV2PlusClient._argsToBytes(
                    VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
                )
            })
        );
              s_requests[requestId].exists=true;
              s_requests[requestId].fulfilled=false;
            //msg.sender will be tracked      
            requestToAddresslogin[requestId]=msg.sender;

        //return         
                return requestId;
         }

         //fallback function

         function fulfillRandomWords( uint256 requestId, uint256[] calldata randomWords) internal override {
         address recepient=requestToAddresslogin[requestId];
         loginMap[recepient].used=false;
         loginMap[recepient].s_lastTimestamp=block.timestamp;
         loginMap[recepient].s_lastRequestId=requestId;
         loginMap[recepient].s_lastResulted=randomWords[0]%500;
         s_requests[requestId].fulfilled=true;
         s_requests[requestId].randomWords=randomWords[0];

        }
        function updateStatus()public{
            require(loginMap[msg.sender].used==false,"failed");
            require(s_requests[loginMap[msg.sender].s_lastRequestId].fulfilled==true,"not available");
            loginMap[msg.sender].used=true;
        }

        //some getter for our frontend
        function returnNumber()public view returns(uint256){
            return loginMap[msg.sender].s_lastResulted;
        } 


}
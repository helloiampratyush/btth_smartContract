// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
contract pvp {
   //function variable
     struct prestigePoints{
        uint256 points;
        uint256 win;
        uint256 loss;
     }

      struct challenged{
        address challenger;
      }
      struct matchInfo{
        bool match_goingOn;
        uint256 s_lastTimeStamp;
        bool s_isLastDefeated;
      }
        struct initiatePvP{
        bool isPvPactive;
        }
     //maping variable
     mapping (address=>matchInfo) public matchInfoReCeipt;
     mapping(address=>prestigePoints) public prestigeMap;
     mapping(address=>challenged[]) public challengeList;
     mapping(address=>initiatePvP) public startpvp;
//function pvp() public
  function ragister(address opponent) public {
    require(matchInfoReCeipt[msg.sender].match_goingOn!=true,"currently match going on");
    challengeList[opponent].push(challenged(msg.sender));
      }          
  function challengAccept(uint256 Index) public{
    challenged memory opponent=challengeList[msg.sender][Index];
    require(prestigeMap[opponent.challenger].points>prestigeMap[msg.sender].points||prestigeMap[msg.sender].points-prestigeMap[opponent.challenger].points<=400,"not eligible");
    require(matchInfoReCeipt[opponent.challenger].s_isLastDefeated!=true,"already defeated"); 
    require(Index<challengeList[msg.sender].length,"Invalid selection");
    require(matchInfoReCeipt[msg.sender].match_goingOn!=true,"currently match going on");
    require(matchInfoReCeipt[ opponent.challenger].match_goingOn!=true,"can't rtn");
    matchInfoReCeipt[msg.sender]=matchInfo(true,block.timestamp,false);
    matchInfoReCeipt[opponent.challenger]=matchInfo(true,block.timestamp,false);
                                              }

  function updateStatusPlayer(address winner,address looser) public{
        require(matchInfoReCeipt[winner].match_goingOn==true,"inv");
        require(matchInfoReCeipt[looser].match_goingOn==true,"inv");
        matchInfoReCeipt[winner]=matchInfo(false,block.timestamp,false);
        matchInfoReCeipt[looser]=matchInfo(false,block.timestamp,true);
        prestigeMap[winner]=prestigePoints(prestigeMap[winner].points+100,prestigeMap[winner].win+1,prestigeMap[winner].loss );
        prestigeMap[looser]=prestigePoints(prestigeMap[looser].points+10,prestigeMap[looser].win,prestigeMap[looser].loss+1 );

      }
  function startPvP() public{
  require(startpvp[msg.sender].isPvPactive==false,"can not start again");
  startpvp[msg.sender].isPvPactive=true;
  }

  function retrieveIsStarted() public view returns(initiatePvP memory){
     return( startpvp[msg.sender]);
  }
  function retrieveMatchInfoReceipt(address to) public view returns(matchInfo memory){
          return(matchInfoReCeipt[to]);
      } 

  function retrieveStamps() public view returns(uint256){
    return(block.timestamp);
  }      
    function retrievePrestigePoints(address to) public view returns(prestigePoints memory){
          return(prestigeMap[to]);
      }
    function retrieveChallengeList() public view returns(challenged[] memory ){
          return( challengeList[msg.sender]);
      }
}

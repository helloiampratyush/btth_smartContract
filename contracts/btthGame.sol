// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract BtthGame {

    // Structs
    struct Character {
        string name;
        string image;
        string level;
        uint256 maxHealth;
        uint256 health;
        uint256 attackDamage;
        uint256 defense;
        string weapon;
        uint256 qi;
        uint256 maxQi;
    }

    struct Skill {
        string name;
        uint256 qiCost;
    }

    struct Flame {
        string name;
        string color;
        uint256 rank;
    }

    struct CharacterInventory {
        uint256 maxQi;
        Skill[] skills;
        Flame[] flames;

    }
//event
 event questCompletionAchievememt(address player,uint256 questIndex);
 event skillAcuireAchievement(address player,string name);
 event flameAcuireAchievement(address player,string name,uint256 rank);

    mapping(address => Character) public players;
    mapping(address => CharacterInventory) public inventories;
    mapping(address=>bool[200]) questReenter;
    string[] private characterImages = [
        "https://ipfs.io/ipfs/Qmay3vWmmBJykcT3gnjwiyPsaVMnVthxEzdCqsmeerxhz6",
        "https://ipfs.io/ipfs/QmXxtdMWeuwvABMUNvD6nVnTXihNGidRw6YLk8KcCceCoU",
        "https://ipfs.io/ipfs/QmXSCRtoxrBPKgTSqvPJkJB4UB6KE5fQowiJKhWNCqwVoS",
        "https://ipfs.io/ipfs/QmRHrKfJVc1DcWw5xEHUtoiku5VXM4a7Z8keaeLc1LMK4L"
    ];

    
    // Functions
    function newGame() public {
        string memory yourCharacterImage = characterImages[0];
        players[msg.sender] = Character("Xiao Yan", yourCharacterImage, "two star dou zhi qi", 200, 200, 0, 0, "nothing", 0, 0);
        for(uint256 i=0;i<200;i++){
            questReenter[msg.sender][i]=false;
        }

    }

    function characterUpdate(
     uint256 questIndex,
     string memory  level,
      uint256 Index,
      uint256 Maxhealth,
      uint256 health,
      uint256 attackDamage,
      uint256 defense,
      string memory  weapon,
      uint256 qi,
      uint256 maxQi) public {
        players[msg.sender]=players[msg.sender] = Character("Xiao Yan", characterImages[Index], level, Maxhealth, health, attackDamage, defense, weapon,qi,maxQi);
        questReenter[msg.sender][questIndex]=true;
        emit questCompletionAchievememt(msg.sender, questIndex);
    }
    
    function inventorySkillUpdate(string memory name,uint256 qiCost) public{
        inventories[msg.sender].skills.push(Skill(name,qiCost));
        emit skillAcuireAchievement(msg.sender, name);
    }

    function inventoeyFlameUpdate(string memory name,string memory color,uint256 rank)public{
        inventories[msg.sender].flames.push(Flame(name,color,rank));
        emit flameAcuireAchievement(msg.sender, name, rank);
    }

        //getter
    function getQuestStatus(uint256 questIndex) public view returns(bool){
           return(questReenter[msg.sender][questIndex]);
        }
        function getCharacterDetails(address to) public view returns(Character memory){
           return(players[to]);
        }
        function getInventory(address to) public view returns(CharacterInventory memory){
            return(inventories[to]);
        }
          
        
}


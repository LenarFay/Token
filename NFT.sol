
/**
 * This file was generated by TONDev.
 * TONDev is a part of TON OS (see http://ton.dev).
 */
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract NFT {
   
    
    struct Token {
        string name;
        uint power;
    }

    Token[] tokenArr;
    mapping (string=>uint) tokenToOwner;
    mapping (string=>uint) tokenCost;

    function createToken (string name, uint power) public returns (string) {
        tvm.accept();
        tokenToOwner[name] = msg.pubkey();
        if (tokenToOwner.exists(name) == false) tokenArr.push(Token(name,power));
        else return ("Error. Token with the same name already exists");
       
    }

    function createCost (string name, uint cost) public returns (Token) {
        tvm.accept();
        require(msg.pubkey() == tokenToOwner[name], 101);
        tokenCost[name] = cost;


    }





    function getTokenOwner(string name) public view returns (uint) {
    
        return tokenToOwner[name];
    }

    function getTokenIngo(uint tokenId) public view returns (string tokenName, uint tokenPower){
        tokenName = tokenArr[tokenId].name;
        tokenPower = tokenArr[tokenId].power;

    }
    
    function changeOwner(string name,uint pubKeyOfNewOwner) public {
        require(msg.pubkey() == tokenToOwner[name], 101);
        tvm.accept();
        tokenToOwner[name] = pubKeyOfNewOwner;


    }

    

    



    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }
}

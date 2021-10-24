
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
        uint cost;
    }
    
    Token[] tokenArr;
    mapping (string => uint) tokenOwner;
    mapping (string => uint) tokenCost;
    mapping (uint => Token) tokenId;

    function createToken (string name, uint power) public returns (uint Id) {
        tvm.accept();
        require (tokenOwner.exists(name) == false, 101);
        tokenArr.push (Token (name, power, 0) );
        tokenOwner[name] = msg.pubkey();
        uint Id = tokenArr.length;
        tokenId[Id] = Token (name, power, 0);
        return Id;
        
       
       
    }

    function sell (string name, uint Id, uint cost) public returns ( Token ){
        tvm.accept();
        require (msg.pubkey() == tokenOwner[name], 101);
        tokenId[Id].cost = cost;
        tokenCost[name] = cost;
    }

    function getTokens () public returns (Token[]) {
        tvm.accept();
        return tokenArr;



    }





    
    

    



    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();

    }
}

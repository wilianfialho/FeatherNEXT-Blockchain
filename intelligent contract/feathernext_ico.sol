// URL para compilar
//http://remix.ethereum.org/#appVersion=0.7.7&optimize=false&version=soljson-v0.4.11+commit.68ef5810.js

//ico feathernext

//versão
pragma solidity ^0.4.11;
 
contract feathercoin_ico {
 
    //número máximo de FeatherNext disponíveis no ICO
    uint public max_feathernext = 5000000000;
    //Taxa cotacao do FeatherNext por dolar
    uint public usd_to_feathernext = 1000;
    //total de FeatherNext compradas por investidores
    uint public total_feathernext_bought = 0;
    
    //funcoes de equivalencia
    mapping(address => uint) equity_feathernext;
    mapping(address => uint) equity_usd;
 
    //verificando se o investidor por comprar FeatherNext
    modifier can_buy_feathernext (uint usd_invested) {
        require (usd_invested * usd_to_feathernext + total_feathernext_bought <= max_feathernext);
        _;
    }
 
    //retorna o valor do investimento em FeatherNext
    function equity_in_feathernext(address investor) external constant returns (uint){
        return equity_feathernext[investor];
    }
 
    //retorna o valor do investimento em dolares
    function equity_in_usd(address investor) external constant returns (uint){
        return equity_usd[investor];
    }
 
    //compra de FeatherNext
    function buy_feathernext(address investor, uint usd_invested) external
    can_buy_feathernext(usd_invested) {
        uint feathernext_bought = usd_invested * usd_to_feathernext;
        equity_feathernext[investor] += feathernext_bought;
        equity_usd[investor] = equity_[investor] / 1000;
        total_feathernext_bought += feathernext_bought;
    }
 
    //venda de FeatherNext
    function sell_feathernext(address investor, uint feathernext_sold) external {
        equity_feathernext[investor] -= feathernext_sold;
        equity_usd[investor] = equity_feathernext[investor] / 1000;
        total_feathernext_bought -= feathernext_sold;
    }
    
    
    
    
}

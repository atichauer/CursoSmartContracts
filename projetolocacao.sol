pragma solidity 0.5.9;

contract Aluguel {
    
    string            public                       locatario;
    string public locadores;
    uint256 private valor;
    uint256 constant numeroMaximoLegalDeAlgueisParaMulta = 3;
    
    locatarios[] public partelocataria;
    locadores[] public partelocadora;
    fiadores[] public partefiadora; 
    imovel[] public dadosimovel;
    
    struct locadores {
        string nome;
        string endereco;
        uint rg;
        uint cpf;
    }
    
    struct locatarios {
        string nome;
        string endereco;
        uint rg;
        uint cpf;
    }
    
    struct fiadores {
        string nome;
        string endereco;
        uint rg;
        uint cpf;
    }
    
    struct imovel {
        string endereco;
        uint matricula;
        string CRI;
    }
    
    constructor(string memory nomeLocador, string memory nomeLocatario, uint256 valorDoAluguel) public {

        locadores = nomeLocador;
        locatario = nomeLocatario;
        valor = valorDoAluguel;
    
    }
 
    function valorAtualDoAluguel() public view returns (uint256) {
        return valor;
    }
    
    function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContato) 
    public view returns(uint256 valorMulta) 
    {

        valorMulta = valor*numeroMaximoLegalDeAlgueisParaMulta;
        valorMulta = valorMulta/totalMesesContato;
        valorMulta = valorMulta*mesesRestantes;

        return valorMulta;
    } 
    
    
    function reajustaAluguel(uint256 percentualReajuste) public {
        uint256 valorDoAcrescimo = 0;

        valorDoAcrescimo = ((valor*percentualReajuste)/100);
        valor = valor + valorDoAcrescimo;
    }
    
}

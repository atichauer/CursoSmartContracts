pragma solidity 0.5.9;

contract Aluguel {
    
    address payable contaRegistrador;
       
    struct imovel {
        string locador;
        uint rgLocador;
        string endLocador;
        bytes32 digidLocador;
        addresspayable contaLodador;
        
        string intermediario;
        uint cnpjIntermediario;
        string endIntermediario;
        bytes32 digidIntermediario;
        addresspayable contaIntermediario;
        
        string locatario;
        uint rgLocatario;
        uint cpfLocatario;
        bytes32 digidLocatario;
                
        string fiador;
        uint rgFiador;
        uint cpfFiador; 
        dytes32 digidFiador;
        
        string enderecoImovel;
        uint numeroImovel
        uint complementoImovel;
        uint CEPImovel;
        
        uint valorLocacao;
        uint prazoLocacao;
     }
    
    mapping(address => Contratante) public listaContratantes;
    Contratante[] public contratantes;
    
    
    constructor(string memory nomeLocador, string memory nomeLocatario, uint256 valorDoAluguel) public {

        locadores = nomeLocador;
        locatario = nomeLocatario;
        valor = valorDoAluguel;
    
    }
    
    function registraLocador
    
    function registraLocatario
    
    function registraFiador
    
    function registraImobiliaria
    
    function pagamentoAluguel
    
    function divideHonorarios
    
    function renovaAluguel
    
    function calculaMulta
    
    
    
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

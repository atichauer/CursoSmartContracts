pragma solidity 0.5.9;

contract Aluguel {
    
    address payable contaRegistrador;
    bool digidCadastrada;
    
    constructor(address payable _contaRegistrador) public {
    
        _contaRegistrador = contaRegistrador;
    
    }
    
    struct imovel {
        string locador;
        uint rgLocador;
        string endLocador;
        bytes32 digidLocador;
        address payable contaLocador;
        
        string locatario;
        uint rgLocatario;
        uint cpfLocatario;
        bytes32 digidLocatario;
                
        string fiador;
        uint rgFiador;
        uint cpfFiador; 
        bytes32 digidFiador;
        
        string enderecoImovel;
        uint numeroImovel;
        uint complementoImovel;
        uint CEPImovel;
        
        uint valorLocacao;
        uint prazoLocacao;
        uint index;
     }
    
    mapping(string => imovel) private DadosDoContrato;
    imovel [] private NumeroDoContrato;
    
     struct UserStruct {
        string userEmail;
        uint userAge;
        uint index;
    }

    function criarContrato(string memory locador, uint rgLocador, string memory endLocador, bytes32 digidLocador, 
        address payable contaLocador, string memory enderecoImovel, uint numeroImovel,
        uint complementoImovel, uint CEPImovel, uint valorLocacao, uint prazoLocacao) public returns(uint index) {
        //require (!isUser(locador), "user exists");
        DadosDoContrato[locador].locador =  locador;
        DadosDoContrato[locador].rgLocador = rgLocador;
        DadosDoContrato[locador].endLocador = endLocador;
        DadosDoContrato[locador].digidLocador = digidLocador;
        DadosDoContrato[locador].contaLocador = contaLocador;
        DadosDoContrato[locador].enderecoImovel = enderecoImovel;
        DadosDoContrato[locador].numeroImovel = numeroImovel;
        DadosDoContrato[locador].complementoImovel = complementoImovel;
        DadosDoContrato[locador].CEPImovel = CEPImovel;
        DadosDoContrato[locador].valorLocacao = valorLocacao;
        DadosDoContrato[locador].prazoLocacao = prazoLocacao;
        //DadosDoContrato[locador].index = NumeroDoContrato.push(locador)-1;
        return NumeroDoContrato.length-1;
        
    //function registraImovel(address paramEndereco, string memory paramNomeProprietario, uint paramValorVenal) public {
      //  Imovel memory novoImovel = Imovel(paramEndereco, paramNomeProprietario, paramValorVenal);
        
        //livro1.push(novoImovel);
        
        //livro2[paramEndereco] = novoImovel;
    //}
    
    //function devolveNomeProprietario(uint matricula) public view returns (string memory) {
    //    return livro1[matricula].nomeProprietario;
    }
    
    //mapping(address => Contratante) public listaContratantes;
    //Contratante[] public contratantes;
    
    
    
    //function registraLocador
    
    //function registraLocatario
    
    //function registraFiador
    
    //function registraImobiliaria
    
    //function pagamentoAluguel
    
    //function divideHonorarios
    
    //function renovaAluguel
    
    //function calculaMulta
    
    
    
    //function simulaMulta( uint256 mesesRestantes, uint256 totalMesesContato) 
    //public view returns(uint256 valorMulta) 
    //{

        //valorMulta = valor*numeroMaximoLegalDeAlgueisParaMulta;
        //valorMulta = valorMulta/totalMesesContato;
        //valorMulta = valorMulta*mesesRestantes;

        //return valorMulta;
    //} 
    
    
    //function reajustaAluguel(uint256 percentualReajuste) public {
      //  uint256 valorDoAcrescimo = 0;

        //valorDoAcrescimo = ((valor*percentualReajuste)/100);
        //valor = valor + valorDoAcrescimo;
    //}
    
}

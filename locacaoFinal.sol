pragma solidity 0.5.9;

contract Aluguel {
    
    address payable contaRegistrador;
    bool digidCadastrada;
    address public contaLocatario;
    
    constructor() public {
    
        contaRegistrador = msg.sender;
    }
    
    modifier SomenteRegistrador () {
        require (msg.sender == contaRegistrador, "Procedimento exclusivo do Registrador");
        _;
    }
    
    struct Contrato {
        string locador;
        uint digidLocador;
        address payable contaLocador;
        
        string locatario;
        uint cpfLocatario;
        uint digidLocatario;
        address contaLocatario;
                
        string enderecoImovel;
        
        uint valorLocacao;
        uint prazoLocacao;
    }
    
    Contrato[] public ListaDeContratos;
    
    function criarContrato 
        (string memory paramlocador, uint paramDigidLocador, address payable paramContaLocador, string memory paramEnderecoImovel, uint paramValorLocacao, uint paramPrazoLocacao) 
        public 
        returns (uint) 
    {
        Contrato memory novoContrato = Contrato (paramlocador, paramDigidLocador, paramContaLocador, " ", 0, 0, address(0), paramEnderecoImovel, paramValorLocacao, paramPrazoLocacao);
        ListaDeContratos.push(novoContrato);
        return ListaDeContratos.length;
    }
    
    function registraLocatario(uint numeroDoContrato, address paramcontaLocatario, string memory paramLocatario, uint paramcpfLocatario, uint paramdigidLocatario) public payable {
        Contrato storage contratoLocacao = ListaDeContratos[numeroDoContrato];
        require (msg.value == contratoLocacao.valorLocacao, "Valor insuficiente");
        contratoLocacao.locatario = paramLocatario;
        contratoLocacao.cpfLocatario = paramcpfLocatario;
        contratoLocacao.digidLocatario = paramdigidLocatario;
    } 
    
    function buscaContratoPorNumero(uint numeroDoContrato) public view returns (string memory, uint, address, string memory, uint, uint, string memory, uint, uint) {
        Contrato memory contratoLocacao = ListaDeContratos[numeroDoContrato];
        return (contratoLocacao.locador, contratoLocacao.digidLocador, contratoLocacao.contaLocador, contratoLocacao.locatario, contratoLocacao.cpfLocatario, contratoLocacao.digidLocatario, contratoLocacao.enderecoImovel, contratoLocacao.valorLocacao, contratoLocacao.prazoLocacao);
    } 
    
    
    
    
    //function pagamentoAluguel
    
    //function divideHonorarios
    
    //function renovaAluguel
    
    //function calculaMulta
  
}

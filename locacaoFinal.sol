pragma solidity 0.5.9;

contract Aluguel {
    
    address payable contaRegistrador;
    bool public digidCadastrada;
    bool public garantiaDepositada;
    bool public pagamentosEfetuados;
    address payable contaLocatario;
    address payable contaLocador;
    uint private valorComissaoRegistrador;
    uint public percentualComissaoRegistrador = 10;
    
    event contratoGarantido (uint);
    event contratoPago (uint);
    event locatarioRegistrado (uint);
    event garantiaEstornada (uint);
    
    constructor() public {
    
        contaRegistrador = msg.sender;
    }
    
    modifier SomenteRegistrador () {
        require (msg.sender == contaRegistrador, "Procedimento exclusivo do Registrador");
        _;
    }
    
    modifier SomenteLocador () {
        require (msg.sender == contaLocador, "Procedimento exclusivo do Locador");
        _;
    }
    
    struct Contrato {
        string locador;
        uint digidLocador;
        address payable contaLocador;
        
        string locatario;
        uint digidLocatario;
        address payable contaLocatario;
                
        string enderecoImovel;
        
        uint valorLocacao;
        uint valorGarantia;
        uint dataInicialLocacao;
        uint dataFinalLocacao;
    }
    Contrato[] public ListaDeContratos;
    
    function criarContrato 
        (string memory paramlocador, uint paramDigidLocador, address payable paramContaLocador, string memory paramEnderecoImovel, uint paramValorLocacao, uint paramvalorGarantia, uint paramDataInicialLocacao, uint paramDataFinalLocacao) 
        public 
        returns (uint) 
    {
        Contrato memory novoContrato = Contrato (paramlocador, paramDigidLocador, paramContaLocador, " ", 0, address(0), paramEnderecoImovel, paramValorLocacao, paramvalorGarantia, paramDataInicialLocacao, paramDataFinalLocacao);
        ListaDeContratos.push(novoContrato);
        return ListaDeContratos.length-1;
    }
    
    function registraLocatario(uint numeroDoContrato, address payable paramcontaLocatario, string memory paramLocatario, uint paramdigidLocatario) public {
        Contrato storage contratoLocacao = ListaDeContratos[numeroDoContrato];
        contratoLocacao.locatario = paramLocatario;
        contratoLocacao.contaLocatario = paramcontaLocatario;
        contratoLocacao.digidLocatario = paramdigidLocatario;
        emit locatarioRegistrado (numeroDoContrato);
    } 
    
    function buscaContratoPorNumero(uint numeroDoContrato) public view returns (string memory, uint, string memory, uint, string memory, uint, uint, uint, uint) {
        Contrato memory contratoLocacao = ListaDeContratos[numeroDoContrato];
        return (contratoLocacao.locador, contratoLocacao.digidLocador, contratoLocacao.locatario, contratoLocacao.digidLocatario, contratoLocacao.enderecoImovel, contratoLocacao.valorLocacao, contratoLocacao.valorLocacao, contratoLocacao.dataInicialLocacao, contratoLocacao.dataFinalLocacao);
    } 
    
    function depositaGarantia (uint numeroDoContrato) public payable {
        Contrato memory contratoLocacao = ListaDeContratos[numeroDoContrato];
        require (msg.value == contratoLocacao.valorGarantia, "Garantia diversa da exigida");
        require (now <= contratoLocacao.dataInicialLocacao, "Imovel não disponível");
        require (!pagamentosEfetuados, "O imóvel já foi locado");
        require (!garantiaDepositada, "Garantia já cadastrada");
        garantiaDepositada = true;
        emit contratoGarantido(numeroDoContrato);
    }
    
    function pagamento (uint numeroDoContrato) public payable {
        Contrato memory contratoLocacao = ListaDeContratos[numeroDoContrato];
        require (garantiaDepositada, "Efetuar o depósito da garantia");
        require (msg.value == contratoLocacao.valorLocacao, "Valor diverso do estipulado pelo Locador");
        require (now <= contratoLocacao.dataInicialLocacao, "Imovel não disponível");
        emit contratoPago(msg.value); numeroDoContrato;
        valorComissaoRegistrador = (10*address(this).balance)/100;
        contaRegistrador.transfer(valorComissaoRegistrador);
        contratoLocacao.contaLocador.transfer(address(this).balance);
        pagamentosEfetuados = true;
        
    }
    
    function estornaGarantia (uint numeroDoContrato) public {
        Contrato memory contratoLocacao = ListaDeContratos [numeroDoContrato];
        require (msg.sender == contratoLocacao.contaLocador, "Usuário não autorizado a realizar esta operação");
        contratoLocacao.contaLocatario.transfer(contratoLocacao.valorGarantia);
        emit garantiaEstornada (numeroDoContrato);
    }
    
  
}

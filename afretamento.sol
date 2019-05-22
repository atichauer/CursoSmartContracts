pragma solidity 0.5.8;

contract afretamento {

    address payable public contaProprietario;
    string constant public Proprietario = "Popeye";
    uint public prazoDePagamento;
    uint public prazoDeAfretamento;
    uint public prazoPagamentoAfretamento;
    uint public taxa;
    uint public garantia;
    string public localDePartida; 
    string public localDeChegada;
    uint public precoCombustivelPartida; 
    uint public quantidadeCombustivelPartida;
    address payable contaAfretador;
    uint public precoTotalCombustivelChegada;
    
    bool public aportado;
    
    event aportou ();
    
    modifier somenteProprietario {
        require(msg.sender == contaProprietario, "Somente Proprietario pode realizar essa operacao");
        _;
    }

    constructor(
        uint _taxa,
        uint _garantia,
        string memory _localDePartida,
        string memory _localDeChegada,
        uint _prazoDeAfretamento,
        uint _prazoPagamentoAfretamento,
        uint _precoCombustivelPartida,
        address payable _contaAfretador,
        uint _quantidadeCombustivelPartida) public {
                                                                                                                        
        prazoDeAfretamento = now + _prazoDeAfretamento;
        taxa = _taxa;
        localDePartida = _localDePartida;
        localDeChegada = _localDeChegada;
        precoCombustivelPartida = _precoCombustivelPartida;
        quantidadeCombustivelPartida = _quantidadeCombustivelPartida;
        prazoPagamentoAfretamento = _prazoPagamentoAfretamento;
        garantia = _garantia;
        contaAfretador = _contaAfretador;
    }

    function pagamentoAfretamento () public payable {
        require (msg.sender == contaAfretador, "Não autorizado a pagar");
        require (now <= prazoPagamentoAfretamento, "Prazo para Contratacao Encerrado");
        require (msg.value == taxa, "Valor diverso do preço do Afretamento");
        
        contaAfretador = msg.sender;
    }
    
    function pagamentoGarantia () public payable {
        require (msg.sender == contaAfretador, "Não autorizado a pagar");
        require (now <= prazoPagamentoAfretamento, "Prazo para Contratacao Encerrado");
        require (msg.value >= garantia, "Valor insuficiente da garantia");
        
        contaAfretador = msg.sender;
        
    }
    
    function calculaCombustivelPartida() public view returns (uint256 PrecoTotalCombustivelPartida) {
        PrecoTotalCombustivelPartida = (precoCombustivelPartida*quantidadeCombustivelPartida);
        return PrecoTotalCombustivelPartida;
    }
    
    function pagamentoCombustivelPartida () public payable {
        require (msg.sender == contaAfretador, "Não autorizado a pagar"); 
        require (now <= prazoPagamentoAfretamento, "Prazo para Contratacao Encerrado");
        require (msg.value == calculaCombustivelPartida(), "Valor diverso do preço do combustível");
        
        contaAfretador = msg.sender;
    }


    function finalizaFrete(uint precoCombustivelChegada, uint quantidadeCombustivelChegada) public somenteProprietario {
        //require(now >= prazoDeAfretamento, "Frete não encerrado - Embarcação em trânsito");
        require(!aportado, "Aportado");
        aportado = true;
        calculaCombustivelChegada (precoCombustivelChegada, quantidadeCombustivelChegada);
        emit aportou();
    }
    
    function calculaCombustivelChegada(uint precoCombustivelChegada, uint quantidadeCombustivelChegada) public returns (uint256) {
        precoTotalCombustivelChegada = (quantidadeCombustivelPartida - quantidadeCombustivelChegada);
        precoTotalCombustivelChegada = (precoTotalCombustivelChegada*precoCombustivelChegada);
        return precoTotalCombustivelChegada;
    }
    
    
    function encontroContas() public view returns (uint256 residual) {
        residual = (garantia - precoTotalCombustivelChegada);
        return residual;
    }
    
    function pagamentos() public somenteProprietario {
        contaAfretador.transfer(address(this).balance-encontroContas());
        contaProprietario.transfer(address(this).balance);
    }
    
}

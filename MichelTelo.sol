pragma solidity 0.5.8;

contract MTFonteNova2019 {

    address payable public contaContrato;
    address payable private contaMichelTelo;
    address desenvolvedor;

    string constant public Tiqueteira = "Time4Fun";
    string constant public Artista = "MichelTelo";
    string constant public Advogado = "AlbertoTichauer";
    uint256 public Bilheteria;
    
    uint public PrazoPagamento;
    bool public pago;
    modifier apenasDesenvolvedor {
        require (msg.sender == contaContrato);
        _;
    }
    
    constructor(
    
        address payable _contaContrato) public {
            contaContrato = _contaContrato;
            uint duracaoContrato;
            PrazoPagamento = now + duracaoContrato;
        
        address payable _contaMicheltelo public {
            contaMichelTelo = _contaMicheltelo;
            
        }    
    }

    function pagamento() public payable {

        require(
            now <= PrazoPagamento,
            "Pagamento em atraso - Contatar Agente."
        );
        require (Bilheteria >= 10000000);
        
        Tiqueteira = msg.sender;
        Bilheteria = msg.value;
     
    }
    
    function finalizaContrato() public apenasDesenvolvedor {
   
        require(now >= PrazoPagamento);
        require(!pago, "Inadimplente.");

        pago = true;
        
        contaContrato.transfer(address(contaMichelTelo).balance*0.95);
    }

}

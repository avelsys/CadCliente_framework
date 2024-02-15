unit CadCliente.DTO.Cliente;

interface

uses
  CadCliente.Commons.Atributos;

type
  [TAtrDTO('tbCliente','Cadastro de Clientes')]
  TCliente = class
  private
    Fcdcliente: Integer;
    FdsName: string;
    FnmCpfCnpj: string;
    FnmRGIE: string;
    FfgTipoCliente: string;
    FdtCadastro: TDateTime;
    FfgAtivo: Boolean;
  public
    [TAtrPropriedadeDTO('Código')]
    property cdcliente: Integer read Fcdcliente write Fcdcliente;
    [TAtrPropriedadeDTO('Nome')]
    property dsName: string read FdsName write FdsName;
    [TAtrPropriedadeDTO('Tipo')]
    property fgTipoCliente: string read FfgTipoCliente write FfgTipoCliente;
    [TAtrPropriedadeDTO('CNPJ/CPF')]
    property nmCpfCnpj: string read FnmCpfCnpj write FnmCpfCnpj;
    [TAtrPropriedadeDTO('RG/IE')]
    property nmRGIE: string read FnmRGIE write FnmRGIE;
    [TAtrPropriedadeDTO('Data Cadastro')]
    property dtCadastro: TDateTime read FdtCadastro write FdtCadastro;
    [TAtrPropriedadeDTO('Ativo')]
    property fgAtivo: Boolean read FfgAtivo write FfgAtivo;
  end;

implementation

end.

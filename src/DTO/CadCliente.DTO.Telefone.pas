unit CadCliente.DTO.Telefone;

interface

uses
  CadCliente.Commons.Atributos;

type
  [TAtrDTO('tbCliente_telefone','Cadastro de Telefones')]
  TTelefone = class
  private
    FcdTelefone: Integer;
    FcdClienteFK: string;
    FnmDDD: string;
    FnmTelefone: string;
  public
    [TAtrPropriedadeDTO('Código')]
    property cdTelefone: Integer read FcdTelefone write FcdTelefone;
    [TAtrPropriedadeDTO('Código Cliente')]
    property cdClienteFK: string read FcdClienteFK write FcdClienteFK;
    [TAtrPropriedadeDTO('DDD')]
    property nmDDD: string read FnmDDD write FnmDDD;
    [TAtrPropriedadeDTO('Telefone')]
    property nmTelefone: string read FnmTelefone write FnmTelefone;
  end;

implementation

end.

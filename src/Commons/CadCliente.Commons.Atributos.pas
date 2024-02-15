unit CadCliente.Commons.Atributos;

interface

uses
  Rtti;

type
  TAtrDTO = class(TCustomAttribute)
  private
    FNomeTabela: string;
    FTituloTela: string;
  public
    constructor Create(ANomeTabela, ATituloTela: string);
    property NomeTabela: string read FNomeTabela write FNomeTabela;
    property TituloTela: string read FTituloTela write FTituloTela;
  end;

  TAtrPropriedadeDTO = class(TCustomAttribute)
  private
    FCaption: string;
  public
    constructor Create(ACaption: string);
    property Caption: string read FCaption write FCaption;
  end;

  TAtrFormulario = class(TCustomAttribute)
  private
    FClassDTO: TClass;
  public
    constructor Create(AClassDTO: TClass);
    property ClassDTO: TClass read FClassDTO write FClassDTO;
  end;

  TAtrFormAuxiliar = class(TCustomAttribute)
  private
    FClassDTO: TClass;
    FIsFrame: Boolean;
  public
    constructor Create(AClassDTO: TClass; AIsFrame: Boolean = true);
    property ClassDTO: TClass read FClassDTO write FClassDTO;
    property IsFrame: Boolean read FIsFrame write FIsFrame;
  end;


implementation

{ TAtrDTO }

constructor TAtrDTO.Create(ANomeTabela, ATituloTela: string);
begin
  FNomeTabela := ANomeTabela;
  FTituloTela := ATituloTela;
end;

{ TAtrPropriedadeDTO }

constructor TAtrPropriedadeDTO.Create(ACaption: string);
begin
  FCaption  := ACaption;
end;

{ TAtrFormulario }

constructor TAtrFormulario.Create(AClassDTO: TClass);
begin
  FClassDTO := AClassDTO;
end;

{ TAtrFormAuxiliar }

constructor TAtrFormAuxiliar.Create(AClassDTO: TClass; AIsFrame: Boolean);
begin
  FClassDTO := AClassDTO;
  FIsFrame  := AIsFrame;
end;

end.

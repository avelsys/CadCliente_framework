unit CadCliente.Controller.Main;

interface

uses
  Vcl.Forms,
  CadCliente.View.BaseCadastro,
  CadCliente.Model.Main.Interfaces;

type
  TControllerMain = class(TInterfacedObject, IModelMain)
  private
    FOWner: TForm;
  public
    constructor Create(AOwner: TForm); reintroduce;
    class function New(AOwner: TForm): IModelMain;
    function ChamarFormulario(AFormClass: TfrnViewBaseCadastroClass):IModelMain;
  end;

implementation

{ TControllerMain }

function TControllerMain.ChamarFormulario(AFormClass: TfrnViewBaseCadastroClass): IModelMain;
var
  LFormulario: TfrnViewBaseCadastro;
begin
  result      := Self;
  LFormulario := AFormClass.Create(FOWner);
  LFormulario.Show;
end;

constructor TControllerMain.Create(AOwner: TForm);
begin
  FOWner:= AOwner;
end;

class function TControllerMain.New(AOwner: TForm): IModelMain;
begin
  Result := TControllerMain.Create(AOwner);

end;

end.

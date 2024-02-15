unit CadCliente.view.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.Actions,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.ComCtrls,
  CadCliente.Model.Main.Interfaces;

type
  TfrmViewMain = class(TForm)
    mmMain: TMainMenu;
    Cadastro1: TMenuItem;
    Clientes1: TMenuItem;
    aclMain: TActionList;
    acCadCliente: TAction;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure acCadClienteExecute(Sender: TObject);
  private
    FControle: IModelMain;
  end;

var
  frmViewMain: TfrmViewMain;

implementation

uses
  CadCliente.Controller.Main,
  CadCliente.view.Cliente;

{$R *.dfm}

procedure TfrmViewMain.acCadClienteExecute(Sender: TObject);
begin
  FControle
    .ChamarFormulario(TfrnViewCliente)
end;

procedure TfrmViewMain.FormCreate(Sender: TObject);
begin
  FControle := TControllerMain.New(Self);
end;

end.

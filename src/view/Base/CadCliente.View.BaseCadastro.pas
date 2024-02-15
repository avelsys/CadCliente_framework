unit CadCliente.View.BaseCadastro;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Data.DB,
  Rtti,
  CadCliente.View.Base,
  CadCliente.Model.ViewBase.Interfaces;

type
  TfrnViewBaseCadastro = class(TfrnViewBase)
    pnlTopo: TPanel;
    pnlBase: TPanel;
    pgcControle: TPageControl;
    tbsListagem: TTabSheet;
    tbsCadastro: TTabSheet;
    dbgListagem: TDBGrid;
    btnCadNovo: TButton;
    btnCadEdiar: TButton;
    btnCadGravar: TButton;
    btnCadDeletar: TButton;
    btnCadCancelar: TButton;
    btnCadSair: TButton;
    procedure FormCreate(Sender: TObject);
  private
    FControle: IModelViewBase;
  end;

var
  frnViewBaseCadastro: TfrnViewBaseCadastro;

implementation

uses
  CadCliente.Controller.BaseCadastro;

{$R *.dfm}

procedure TfrnViewBaseCadastro.FormCreate(Sender: TObject);
begin
  inherited;
  FControle := TControllerBaseCadastro.New(Self);
end;

end.

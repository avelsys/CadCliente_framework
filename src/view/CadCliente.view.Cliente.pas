unit CadCliente.view.Cliente;

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
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Data.DB,
  CadCliente.View.BaseCadastro,
  CadCliente.Commons.Atributos,
  CadCliente.DTO.Cliente,
  CadCliente.DTO.Telefone,
  CadCliente.View.Frame.Base;

type
  [TAtrFormAuxiliar(TTelefone)]
  [TAtrFormulario(TCliente)]
  TfrnViewCliente = class(TfrnViewBaseCadastro)
  end;

var
  frnViewCliente: TfrnViewCliente;

implementation

{$R *.dfm}

end.

unit CadCliente.View.Frame.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfmeViewBase = class(TFrame)
    pnlSide: TPanel;
    nvtNavegador: TDBNavigator;
    pgcControleFrame: TPageControl;
    tbsFrameListagem: TTabSheet;
    tbsFrameCadastro: TTabSheet;
    gbxTitulo: TGroupBox;
    dbgListagemFrame: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

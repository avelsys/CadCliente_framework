unit CadCliente.View.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrnViewBase = class(TForm)
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  end;

var
  frnViewBase: TfrnViewBase;

implementation

{$R *.dfm}

procedure TfrnViewBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action      := caFree;
  frnViewBase := nil;
end;

procedure TfrnViewBase.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then begin
    Key := #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

end.

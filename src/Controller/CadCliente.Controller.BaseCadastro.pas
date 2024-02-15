unit CadCliente.Controller.BaseCadastro;

interface

uses
  System.Classes,
  System.SysUtils,
  System.TypInfo,
  System.Actions,
  System.StrUtils,
  System.AnsiStrings,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.DBCtrls,
  System.Rtti,
  Data.DB,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  Generics.Collections,
  CadCliente.View.BaseCadastro,
  CadCliente.Model.ViewBase.Interfaces,
  CadCliente.Commons.Constantes,
  CadCliente.Dao.Model.Conexao,
  CadCliente.Dao.Controller.ConSqlServer,
  CadCliente.View.Frame.Base;

type
  TFormAuxiliar = record
    Caption: string;
    NomeTabela: string;
    FrameAuxiliar: TfmeViewBase;
    ChavePrimaria: TField;
    DataSetAuxiliar: TFDQuery;
    DataSourceAuxiliar: TDataSource;
  end;

  TListaBotoesTela      = TDictionary<string,TButton>;
  TListaFormAuxiliares  = TDictionary<string,TFormAuxiliar>;

  THelperRtti = Class Helper For TRttiType
  public
    function PegarField<T: TComponent>(const AInstance: Pointer; ANomeField: string): T;
    function PegarAtributo<T: TCustomAttribute>(const AInstance: Pointer): T;
  End;

  TControllerBaseCadastro = class(TInterfacedObject, IModelViewBase)
  private
    FConexao: TDaoConexao;
    FCadView: TForm;
    FClassDTO: TClass;
    FCtxRttiFormulario: TRttiContext;
    FDataSourceConsulta: TDataSource;
    FDataSourceCadastro: TDataSource;
    FNomeTabela: string;
    FDataSetConsulta: TFDQuery;
    FDataSetCadastro: TFDQuery;
    FListaBotoesTela: TListaBotoesTela;
    FPaginaControle: TPageControl;
    FTBSListagem: TTabSheet;
    FTBSCadastro: TTabSheet;
    FDBGListagem: TDBGrid;
    FListaAcoesBtn: TActionList;
    FListaFormAuxiliares: TListaFormAuxiliares;
    function PegarTypeAtributoTela: TRttiType;
    procedure CriarDataSets;
    procedure MontarControlesTela;
    procedure MontarAcoesBotaoTela;
    procedure CriarAcao(LKey: string; AEvento: TNotifyEvent =  nil);
    procedure MontarAcessosBotaoTela;
    procedure MontarEditores;
    procedure MontarFormAuxiliares;
    function PegarTypeAtributoDTO: TRttiType;
  protected
    procedure DoExecuteNovo(Sender: TObject);
    procedure DoExecuteEditar(Sender: TObject);
    procedure DoExecuteGravar(Sender: TObject);
    procedure DoExecuteDeletar(Sender: TObject);
    procedure DoExecuteCancelar(Sender: TObject);
    procedure DoExecuteSair(Sender: TObject);
  public
    constructor Create(AOwner: TForm); reintroduce;
    destructor Destroy; override;

    class function New(AOwner: TForm): IModelViewBase;
  end;

  var
    Linha: Integer;
    Coluna: Integer;
    Espaco: Integer;
    TamanhoCampo: Integer;

implementation

uses
  CadCliente.Commons.Atributos, System.UITypes;

{ TControllerBaseCadastro }

class function TControllerBaseCadastro.New(AOwner: TForm): IModelViewBase;
begin
  Result := TControllerBaseCadastro.Create(AOwner);
end;

constructor TControllerBaseCadastro.Create(AOwner: TForm);
begin
  FCadView                    := AOwner;
  FConexao                    := TDaoConexao.Create(tcSQLSERVER);
  FListaAcoesBtn              := TActionList.Create(AOwner);
  FListaBotoesTela            := TListaBotoesTela.Create;
  FListaFormAuxiliares        := TListaFormAuxiliares.Create;
  MontarControlesTela;
  CriarDataSets;
  MontarAcoesBotaoTela;
  MontarAcessosBotaoTela;
  FPaginaControle.ActivePage  := FTBSListagem;
  MontarEditores;
  MontarFormAuxiliares;
end;

function TControllerBaseCadastro.PegarTypeAtributoTela: TRttiType;
begin
  FCtxRttiFormulario:= TRttiContext.Create;
  try
    Result := FCtxRttiFormulario.GetType(FCadView.ClassInfo);
  finally
    //
  end;
end;

function TControllerBaseCadastro.PegarTypeAtributoDTO: TRttiType;
begin
  FCtxRttiFormulario:= TRttiContext.Create;
  try
    Result := FCtxRttiFormulario.GetType(FClassDTO.ClassInfo);
  finally
    //
  end;
end;

procedure TControllerBaseCadastro.MontarControlesTela;
var
  LField: TRttiField;
  LFieldName: string;
begin
  FPaginaControle := PegarTypeAtributoTela.PegarField<TPageControl>(FCadView, csVIEW_PAGINA_CONTROLE);
  FTBSListagem    := PegarTypeAtributoTela.PegarField<TTabSheet>(FCadView,    csVIEW_PAGINA_LISTAGEM);
  FTBSCadastro    := PegarTypeAtributoTela.PegarField<TTabSheet>(FCadView,    csVIEW_PAGINA_CADASTRO);
  FDBGListagem    := PegarTypeAtributoTela.PegarField<TDBGrid>(FCadView,      csVIEW_GRID_LISTAGEM);

  for LField in PegarTypeAtributoTela.GetFields do
  begin
    LFieldName  := LField.Name;
    if MatchStr(LFieldName, csVETOR_BOTOES_TELA)  then
      FListaBotoesTela.Add(LFieldName, LField.GetValue(FCadView).AsType<TButton>)
  end;
end;

procedure TControllerBaseCadastro.MontarEditores;
var
  LField: TField;
  LDBEdit: TDBEDit;
  LLabel: TLabel;
begin
  Linha        := FTBSCadastro.Top  + 10;
  Coluna       := FTBSCadastro.Left + 10;
  Espaco       := 20;
  TamanhoCampo := 0;

  for LField in FDataSetCadastro.Fields do
  begin
    LLabel              := TLabel.Create(FTBSCadastro);
    LLabel.Parent       := FTBSCadastro;
    LLabel.Name         := Format('lbl%s',[LField.FieldName]);
    LLabel.Caption      := LField.DisplayLabel;
    LLabel.Top          := Linha;
    LLabel.Left         := Coluna;

    LDBEdit             := TDBEdit.Create(FTBSCadastro);
    LDBEdit.Parent      := FTBSCadastro;
    LDBEdit.Name        := Format('edt%s',[LField.FieldName]);
    LDBEdit.DataSource  := FDataSourceCadastro;
    LDBEdit.DataField   := LField.FieldName;
    LDBEdit.Top         := Linha + Espaco;
    LDBEdit.Left        := Coluna;
    LDBEdit.Width       := Trunc((LField.DisplayWidth * 10) / 2);
    if LDBEdit.Width < LLabel.Width then
      LDBEdit.Width     := LLabel.Width * 2;

    if LDBEdit.Width > TamanhoCampo then
      TamanhoCampo     := LDBEdit.Width;

    if (TamanhoCampo + 20) >  FTBSCadastro.Width then
    begin
      Linha := Linha + 50;
    end;

    Coluna := Coluna + LDBEdit.Width + 10;

  end;
end;

procedure TControllerBaseCadastro.MontarFormAuxiliares;
var
  LCtxRtti: TRttiContext;
  LTypRtti: TRttiType;
//  LPropRtti: TRttiProperty;
  LAtbtRtti, LAtbtRttiDTO: TCustomAttribute;
  LFrmAuxiliar: TAtrFormAuxiliar;
  LFormAux: TFormAuxiliar;
begin
  Linha  := Linha + 50;
  Coluna := FTBSCadastro.Left +10;
  for LAtbtRtti in PegarTypeAtributoTela.GetAttributes do
  begin
    if LAtbtRtti is TAtrFormAuxiliar then
    begin
      LFrmAuxiliar := LAtbtRtti as TAtrFormAuxiliar;
      LCtxRtti:= TRttiContext.Create;
      try
        LTypRtti:= LCtxRtti.GetType(LFrmAuxiliar.ClassDTO.ClassInfo);
        for LAtbtRttiDTO in LTypRtti.GetAttributes do
        begin
          if LAtbtRttiDTO is TAtrDTO then
          begin
            LFormAux.Caption     := TAtrDTO(LAtbtRttiDTO).TituloTela;
            LFormAux.NomeTabela  := TAtrDTO(LAtbtRttiDTO).NomeTabela;
          end;
        end;

//        for LPropRtti in LTypRtti.GetProperties do
//          for LAtbtRttiDTO in LPropRtti.GetAttributes do
//            if LAtbtRttiDTO is TAtrPropriedadeDTO then
//            begin
//              LFormAux.Caption     := TAtrPropriedadeDTO(LAtbtRttiDTO).TituloTela;
//              LFormAux.NomeTabela  := TAtrPropriedadeDTO(LAtbtRttiDTO).NomeTabela;
//            end;            

        LFormAux.FrameAuxiliar                    := TfmeViewBase.Create(FTBSCadastro);
        LFormAux.FrameAuxiliar.Parent             := FTBSCadastro;
        LFormAux.FrameAuxiliar.gbxTitulo.Caption  := LFormAux.Caption;
        LFormAux.FrameAuxiliar.Top                := Linha;
        LFormAux.FrameAuxiliar.Left               := Coluna;
        
        LFormAux.ChavePrimaria                    := nil;
        LFormAux.DataSetAuxiliar                  := TFDQuery.Create(LFormAux.FrameAuxiliar);
        LFormAux.DataSourceAuxiliar               := TDataSource.Create(LFormAux.FrameAuxiliar);
        with LFormAux.FrameAuxiliar do
        begin
          dbgListagemFrame.DataSource := LFormAux.DataSourceAuxiliar;
        end;
        FListaFormAuxiliares.Add(LFormAux.Caption, LFormAux);

      finally
        LCtxRtti.free;
      end;
    end;
  end;



end;

procedure TControllerBaseCadastro.MontarAcoesBotaoTela;
var
  LKey: string;
begin
  for LKey in FListaBotoesTela.Keys do
  begin
    case TBotoao_Tela(AnsiIndexStr(LKey, csVETOR_BOTOES_TELA)) of
      enVIEW_BOTAO_NOVO:
          CriarAcao(LKey, DoExecuteNovo);
      enVIEW_BOTAO_EDITAR:
          CriarAcao(LKey, DoExecuteEditar);
      enVIEW_BOTAO_GRAVAR:
          CriarAcao(LKey, DoExecuteGravar);
      enVIEW_BOTAO_DELETAR:
          CriarAcao(LKey, DoExecuteDeletar);
      enVIEW_BOTAO_CANCELAR:
          CriarAcao(LKey, DoExecuteCancelar);
      enVIEW_BOTAO_SAIR:
          CriarAcao(LKey, DoExecuteSair);
    end;
  end;
end;

procedure TControllerBaseCadastro.CriarAcao(LKey: string; AEvento: TNotifyEvent =  nil);
var
  LAcao: TAction;
  LBotao: TButton;
begin
  var Index := AnsiIndexStr(LKey, csVETOR_BOTOES_TELA);

  LAcao             := TAction.Create(FListaAcoesBtn);
  LAcao.ActionList  := FListaAcoesBtn;
  LAcao.name        := Format('act_%s', [LKey]);
  LAcao.ShortCut    := TextToShortCut(csVETOR_SHORTCUT_BOTOES[Index]);
  LAcao.Caption     := csVETOR_CAPTION_BOTOES[Index];
  LAcao.Hint        := csVETOR_HINT_BOTOES[Index];
  LAcao.OnExecute   := AEvento;
  LBotao            := FListaBotoesTela[LKey];
  LBotao.Action     := LAcao;
  LBotao.ShowHint   := True;
end;

procedure TControllerBaseCadastro.MontarAcessosBotaoTela;
  function ChecarEdicao: Boolean;
  begin
    result := (not (FDataSetCadastro.State in dsEditModes)) and
              (FDataSetConsulta.Active);
  end;
  function ChecarModificacao: Boolean;
  begin
    result := (FDataSetCadastro.State in dsEditModes) and
              (FDataSetConsulta.Active);
  end;
begin
  FListaBotoesTela[csVIEW_BOTAO_NOVO].Enabled     := ChecarEdicao;
  FListaBotoesTela[csVIEW_BOTAO_EDITAR].Enabled   := ChecarEdicao and not FDataSetConsulta.IsEmpty;
  FListaBotoesTela[csVIEW_BOTAO_GRAVAR].Enabled   := ChecarModificacao;
  FListaBotoesTela[csVIEW_BOTAO_DELETAR].Enabled  := ChecarEdicao and not FDataSetConsulta.IsEmpty;
  FListaBotoesTela[csVIEW_BOTAO_CANCELAR].Enabled := ChecarModificacao;
end;

procedure TControllerBaseCadastro.CriarDataSets;
var
  LSelectBase: string;
  LPrpRtti: TRttiProperty;
  LAtributo: TCustomAttribute;
  LAtrDTO: TAtrPropriedadeDTO;
  LFieldName: string;
  LField: TField;
begin
  FClassDTO                 := PegarTypeAtributoTela.PegarAtributo<TAtrFormulario>(FCadView).ClassDTO;
  FNomeTabela               := PegarTypeAtributoDTO.PegarAtributo<TAtrDTO>(FCadView).NomeTabela;
  FCadView.Caption          := PegarTypeAtributoDTO.PegarAtributo<TAtrDTO>(FCadView).TituloTela;
  LSelectBase               := Format(' SELECT * FROM %s ',[FNomeTabela]);
  FDataSetConsulta          := TFDQuery.Create(FCadView);
  FConexao.SetarConexao(FDataSetConsulta);
  FDataSetConsulta.SQL.Text := LSelectBase;
  FDataSetConsulta.Open;

  FDataSetCadastro          := TFDQuery.Create(FCadView);
  FConexao.SetarConexao(FDataSetCadastro);
  FDataSetCadastro.SQL.Text := LSelectBase;
  FDataSetCadastro.Open;

  FDataSourceConsulta           := TDataSource.Create(FCadView);
  FDataSourceConsulta.DataSet   := FDataSetConsulta;

  FDataSourceCadastro           := TDataSource.Create(FCadView);
  FDataSourceCadastro.DataSet   := FDataSetCadastro;

  FDBGListagem.DataSource   := FDataSourceConsulta;


  for LPrpRtti in PegarTypeAtributoDTO.GetProperties do
  begin
    for LAtributo in LPrpRtti.GetAttributes do
    begin
      if LAtributo is TAtrPropriedadeDTO then
      begin
        LAtrDTO             := LAtributo as TAtrPropriedadeDTO;
        LFieldName          := LPrpRtti.Name;
        LField              := FDataSetConsulta.FindField(LFieldName);
        LField.DisplayLabel := LAtrDTO.Caption;

        LField              := FDataSetCadastro.FindField(LFieldName);
        LField.DisplayLabel := LAtrDTO.Caption;
      end;
    end;
  end;
end;

destructor TControllerBaseCadastro.Destroy;
begin
  FConexao.Free;
  FListaBotoesTela.Free;
  FCtxRttiFormulario.Free;
  FListaFormAuxiliares.Free;
  inherited;
end;

procedure TControllerBaseCadastro.DoExecuteCancelar(Sender: TObject);
begin
  FDataSetCadastro.Cancel;
  MontarAcessosBotaoTela;
  FPaginaControle.ActivePage  := FTBSListagem
end;

procedure TControllerBaseCadastro.DoExecuteDeletar(Sender: TObject);
begin
  FPaginaControle.ActivePage  := FTBSCadastro;
  if MessageDlg('Deseja excluir este Registro?',mtConfirmation,[mbYes, mbNo],0) = mrYes  then
  begin
    FDataSetCadastro.Delete;
    FDataSetCadastro.ApplyUpdates();    
    MontarAcessosBotaoTela;
  end;
  FPaginaControle.ActivePage  := FTBSListagem;    
end;

procedure TControllerBaseCadastro.DoExecuteEditar(Sender: TObject);
begin
  FDataSetCadastro.Edit;
  MontarAcessosBotaoTela;
  FPaginaControle.ActivePage  := FTBSCadastro;
end;

procedure TControllerBaseCadastro.DoExecuteGravar(Sender: TObject);
begin
  FDataSetCadastro.Post;
  FDataSetCadastro.ApplyUpdates();
  MontarAcessosBotaoTela;
  FPaginaControle.ActivePage  := FTBSListagem;
  FDataSetConsulta.Refresh;
end;

procedure TControllerBaseCadastro.DoExecuteNovo(Sender: TObject);
begin
  FDataSetCadastro.Insert;
  MontarAcessosBotaoTela;
  FPaginaControle.ActivePage  := FTBSCadastro;
end;

procedure TControllerBaseCadastro.DoExecuteSair(Sender: TObject);
begin
  FCadView.Close;
end;

{ THelperRtti }

function THelperRtti.PegarAtributo<T>(const AInstance: Pointer): T;
begin
  Result := GetAttribute<T>;
end;

function THelperRtti.PegarField<T>(const AInstance: Pointer; ANomeField: string): T;
begin
  if GetField(ANomeField) = nil then
    raise Exception.Create(format('Erro: Não foram encontrados atributos para "%s" ', [ANomeField]));

  Result := GetField(ANomeField).GetValue(AInstance).AsType<T>;
end;

end.

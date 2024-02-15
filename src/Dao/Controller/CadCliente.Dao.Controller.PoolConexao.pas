unit CadCliente.Dao.Controller.PoolConexao;

interface

uses
  System.SysUtils,
  System.Types,
  System.IniFiles,
  System.IOUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  CadCliente.Dao.Model.Conexao,
  CadCliente.Commons.Constantes;

type
  TAngelysDaoConexaoPool = class(TInterfacedObject, iConexaoPool)
  private
    FConexao: TFDConnection;
    FNomeConexao: string;
    FNomeLocal: string;
    FNomeBanco: string;
    FUsuario: string;
    FSenha: string;
    FNomeDriver: string;
    FDriver: string;
    FBibliotecaEndereco: string;
    FParamConexao: TDefineParamConexao;
    function ConfigurarConexao(
      const AConnectionDefDriverParams: TConnectionDefDriverParams;
      const AParametrosConexao: TConnectionDefParams;
      const AConnectionDefPoolParams: TConnectionDefPoolParams): iConexaoPool; overload;
    procedure MontarConexao;
    procedure ConfiguarDadosConexao;
    function GetNomeConexao: string;
    function GetBibliotecaEndereco: string;
    function GetDriver: string;
    function GetNomeBanco: string;
    function GetNomeDriver: string;
    function GetNomeLocal: string;
    function Getusuario: string;
    function GetSenha: string;
  protected
    constructor Create(AParamConexao: TDefineParamConexao);
    procedure DefinirParametroConexao(
      AParametrosConexao: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams);
  public
    destructor Destroy; override;
    class function New(AParamConexao: TDefineParamConexao): iConexaoPool;
    function SetarConexao(out AQuery: TFDQuery): iConexaoPool;
    function PegarConexao: TFDConnection;
    function IsConnected: Boolean;
    property nomeconexao: string read GetNomeConexao;
    property NomeLocal: string read GetNomeLocal;
    property NomeBanco: string read GetNomeBanco;
    property Usuario: string read Getusuario;
    property Senha: string read  GetSenha;
    property NomeDriver: string read GetNomeDriver;
    property Driver: string read GetDriver;
    property BibliotecaEndereco: string read GetBibliotecaEndereco;
  end;

implementation

constructor TAngelysDaoConexaoPool.Create(AParamConexao: TDefineParamConexao);
begin
  FParamConexao:= AParamConexao;
  ConfiguarDadosConexao;
  MontarConexao;
end;

procedure TAngelysDaoConexaoPool.MontarConexao;
var
  LConnectionDefDriverParams: TConnectionDefDriverParams;
  LConnectionDefParams: TConnectionDefParams;
  LConnectionDefPoolParams: TConnectionDefPoolParams;
begin

  LConnectionDefDriverParams.DriverDefName := FDriver;

  if not FBibliotecaEndereco.IsEmpty then
    if not FileExists(FBibliotecaEndereco) then
      raise Exception.Create(format('A Dll [%s] da biblioteca de conexao não foi encontrada neste caminho.',[FBibliotecaEndereco]))
    else
      LConnectionDefDriverParams.VendorLib := FBibliotecaEndereco;

  LConnectionDefParams.ConnectionDefName      := FNomeConexao;
  LConnectionDefParams.Server                 := FNomeLocal;
  LConnectionDefParams.Database               := FNomeBanco;
  LConnectionDefParams.UserName               := Fusuario;
  LConnectionDefParams.Password               := FSenha;
  LConnectionDefParams.LocalConnection        := True;

  LConnectionDefPoolParams.Pooled             := true;
  LConnectionDefPoolParams.PoolMaximumItems   := 50;
  LConnectionDefPoolParams.PoolCleanupTimeout := 30000;
  LConnectionDefPoolParams.PoolExpireTimeout  := 60000;

  ConfigurarConexao(LConnectionDefDriverParams,
                    LConnectionDefParams,
                    LConnectionDefPoolParams);

   FConexao := TFDConnection.Create(nil);
end;

procedure TAngelysDaoConexaoPool.ConfiguarDadosConexao;
begin
  FNomeConexao        := csNOME_CONEXAO;
  FNomeLocal          := csHOSTNAME;
  FNomeBanco          := csDATABASE;
  FUsuario            := csUSER;
  FSenha              := csPASSWORD;
  FNomeDriver         := csDRIVER_CONEXAO;
  FDriver             := csDRIVER;
  FBibliotecaEndereco := csVENDOR_LIBRARY;
end;

function TAngelysDaoConexaoPool.ConfigurarConexao(
      const AConnectionDefDriverParams: TConnectionDefDriverParams;
      const AParametrosConexao: TConnectionDefParams;
      const AConnectionDefPoolParams: TConnectionDefPoolParams): iConexaoPool;
var
  LConnection: TFDCustomConnection;
  LFDStanConnectionDef: IFDStanConnectionDef;
  LFDStanDefinition: IFDStanDefinition;
begin
  Result := Self;
  FDManager.CloseConnectionDef(AParametrosConexao.ConnectionDefName);
  FDManager.ActiveStoredUsage         := [auRunTime];
  FDManager.ConnectionDefFileAutoLoad := False;
  FDManager.DriverDefFileAutoLoad     := False;
  FDManager.SilentMode                := True;

  LFDStanDefinition := FDManager.DriverDefs.FindDefinition(AConnectionDefDriverParams.DriverDefName);
  if not Assigned(FDManager.DriverDefs.FindDefinition(AConnectionDefDriverParams.DriverDefName)) then
  begin
    LFDStanDefinition := FDManager.DriverDefs.Add;
    LFDStanDefinition.Name := AConnectionDefDriverParams.DriverDefName;
  end;
  LFDStanDefinition.AsString[csBASE_DRIVER_ID] := FDriver;
  if not AConnectionDefDriverParams.VendorLib.Trim.IsEmpty then
    LFDStanDefinition.AsString[csVENDOR_LIB] := AConnectionDefDriverParams.VendorLib;

  LFDStanConnectionDef := FDManager.ConnectionDefs.FindConnectionDef(AParametrosConexao.ConnectionDefName);
  if not Assigned(FDManager.ConnectionDefs.FindConnectionDef(AParametrosConexao.ConnectionDefName)) then
  begin
    LFDStanConnectionDef := FDManager.ConnectionDefs.AddConnectionDef;
    LFDStanConnectionDef.Name := AParametrosConexao.ConnectionDefName;
  end;

  DefinirParametroConexao(AParametrosConexao,
                          AConnectionDefDriverParams,
                          LFDStanConnectionDef,
                          AConnectionDefPoolParams);

  LConnection := TFDCustomConnection.Create(nil);
  try
    LConnection.FetchOptions.Mode := TFDFetchMode.fmAll;
    LConnection.ResourceOptions.AutoConnect := False;

    with LConnection.FormatOptions.MapRules.Add do
    begin
      SourceDataType := dtDateTime;
      TargetDataType := dtDateTimeStamp;
    end;

    LFDStanConnectionDef.WriteOptions(LConnection.FormatOptions,
                                      LConnection.UpdateOptions,
                                      LConnection.FetchOptions,
                                      LConnection.ResourceOptions,
                                      nil);
  finally
    LConnection.Free;
  end;

  if (FDManager.State <> TFDPhysManagerState.dmsActive) then
    FDManager.Open;

end;

procedure TAngelysDaoConexaoPool.DefinirParametroConexao(
  AParametrosConexao: TConnectionDefParams;
  AConnectionDefDriverParams: TConnectionDefDriverParams;
  AFDStanConnectionDef: IFDStanConnectionDef;
  AConnectionDefPoolParams: TConnectionDefPoolParams);
begin
  if Assigned(FParamConexao) then
    FParamConexao(AParametrosConexao,
                  AConnectionDefDriverParams,
                  AFDStanConnectionDef,
                  AConnectionDefPoolParams);
end;

destructor TAngelysDaoConexaoPool.Destroy;
begin
  if Assigned(FConexao) then
    FConexao.Free;
  inherited;
end;

function TAngelysDaoConexaoPool.GetBibliotecaEndereco: string;
begin
  result := FBibliotecaEndereco;
end;

function TAngelysDaoConexaoPool.GetDriver: string;
begin
  result := FDriver;
end;

function TAngelysDaoConexaoPool.GetNomeBanco: string;
begin
  result := FNomeBanco;
end;

function TAngelysDaoConexaoPool.GetNomeConexao: string;
begin
  result := FNomeConexao;
end;

function TAngelysDaoConexaoPool.GetNomeDriver: string;
begin
  result := FNomeDriver;
end;

function TAngelysDaoConexaoPool.GetNomeLocal: string;
begin
  result := FNomeLocal;
end;

function TAngelysDaoConexaoPool.GetSenha: string;
begin
  result := FSenha;
end;

function TAngelysDaoConexaoPool.Getusuario: string;
begin
  result := FUsuario;
end;

function TAngelysDaoConexaoPool.IsConnected: Boolean;
var
  LFDConnection: TFDConnection;
begin
  LFDConnection := TFDConnection.Create(nil);
  try
    LFDConnection.ConnectionDefName := FNomeConexao;
    LFDConnection.Connected         := True;
    Result := LFDConnection.Connected;
  finally
    LFDConnection.Free;
  end;
end;

class function TAngelysDaoConexaoPool.New(AParamConexao: TDefineParamConexao): iConexaoPool;
begin
  Result := Self.Create(AParamConexao);
end;

function TAngelysDaoConexaoPool.PegarConexao: TFDConnection;
begin
  FConexao.ConnectionDefName := FNomeConexao;
  result := FConexao;
end;

function TAngelysDaoConexaoPool.SetarConexao(out AQuery: TFDQuery): iConexaoPool;
begin
  Result := Self;
  AQuery.Connection                   := FConexao;
  AQuery.Connection.ConnectionDefName := FNomeConexao;
end;

end.

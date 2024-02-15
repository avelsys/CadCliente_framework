unit CadCliente.Dao.Controller.ConSqlServer;

interface

uses
   Data.DB
  ,FireDAC.Stan.Intf
  ,FireDAC.Stan.Option
  ,FireDAC.Stan.Error
  ,FireDAC.UI.Intf
  ,FireDAC.Phys.Intf
  ,FireDAC.Stan.Def
  ,FireDAC.Phys
  ,FireDAC.Comp.Client
  ,FireDAC.Comp.DataSet
  ,FireDAC.Phys.MSSQL
  ,FireDAC.Phys.MSSQLDef
  ,FireDAC.Phys.MSSQLWrapper
  ,CadCliente.Dao.Model.Conexao
  ,CadCliente.Dao.Controller.PoolConexao;

type
  TDaoConexao = class
  private
    FListaCamposTabela: TListaCamposTabela;
    FDriverMSSQL: TFDPhysMSSQLDriverLink;
  protected
    procedure ConexaoMSSQL(
      AParametrosConexao: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams);
  public
    FConexao: iConexaoPool;
    constructor Create(const ATipoConexao: TTipoConexao = tcSQLSERVER ); virtual;
    destructor Destroy; override;
    function SetarConexao(out AQuery: TFDQuery): TDaoConexao; overload;
    function IsConected: Boolean;
    function Commit: TDaoConexao;
    function RollBack: TDaoConexao;
    function AbreTransacao: TDaoConexao;
    function PegarConexao: TFDConnection;
  end;

implementation

procedure TDaoConexao.ConexaoMSSQL(
      AParametrosConexao: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams);
var
  LConnectionDefParams: TFDPhysMSSQLConnectionDefParams;
begin
  FDriverMSSQL := TFDPhysMSSQLDriverLink.Create(nil);

  LConnectionDefParams                    := TFDPhysMSSQLConnectionDefParams(AFDStanConnectionDef.Params);
  LConnectionDefParams.DriverID           := AConnectionDefDriverParams.DriverDefName;
  LConnectionDefParams.Database           := AParametrosConexao.Database;
  LConnectionDefParams.UserName           := AParametrosConexao.UserName;
  LConnectionDefParams.Password           := AParametrosConexao.Password;
  LConnectionDefParams.Server             := AParametrosConexao.Server;

  LConnectionDefParams.Pooled             := AConnectionDefPoolParams.Pooled;
  LConnectionDefParams.PoolMaximumItems   := AConnectionDefPoolParams.PoolMaximumItems;
  LConnectionDefParams.PoolCleanupTimeout := AConnectionDefPoolParams.PoolCleanupTimeout;
  LConnectionDefParams.PoolExpireTimeout  := AConnectionDefPoolParams.PoolExpireTimeout;
end;

function TDaoConexao.AbreTransacao: TDaoConexao;
begin
  Result := Self;
  FConexao.PegarConexao.StartTransaction;
end;

function TDaoConexao.Commit: TDaoConexao;
begin
  Result := Self;
  FConexao.PegarConexao.Commit;
end;

constructor TDaoConexao.Create(const ATipoConexao: TTipoConexao = tcSQLSERVER );
begin
  FListaCamposTabela  := TListaCamposTabela.Create;
  case ATipoConexao of
    tcSQLSERVER : FConexao := TAngelysDaoConexaoPool.New(ConexaoMSSQL);
  end;
end;

destructor TDaoConexao.Destroy;
begin
  if Assigned(FDriverMSSQL) then
    FDriverMSSQL.Free;

  if Assigned(FListaCamposTabela) then
    FListaCamposTabela.Free;

  inherited;
end;

function TDaoConexao.IsConected: Boolean;
begin
  Result := FConexao.IsConnected;
end;

function TDaoConexao.PegarConexao: TFDConnection;
begin
  Result := FConexao.PegarConexao;
end;

function TDaoConexao.SetarConexao(out AQuery: TFDQuery): TDaoConexao;
begin
  result:= Self;
  AQuery.CachedUpdates := True;
  FConexao.SetarConexao(AQuery);
end;

function TDaoConexao.RollBack: TDaoConexao;
begin
  result := Self;
  FConexao.PegarConexao.Rollback;
end;

end.


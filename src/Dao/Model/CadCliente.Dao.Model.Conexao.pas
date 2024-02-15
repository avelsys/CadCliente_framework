unit CadCliente.Dao.Model.Conexao;

interface

uses
  FireDAC.Comp.Client,
  Generics.Collections,
  Data.DB,
  FireDAC.Stan.Intf;

type
  TTipoConexao = (tcSQLSERVER, tcSQLITE);

  TCamposTabela = record
    Campo: string;
    ChavePrimaria: Boolean;
    LookUp: Boolean;
    DisplayLabel: string;
    TipoCampo: TFieldType;
    Tamanho: Integer;
  end;

  TListaCamposTabela = TDictionary<string,TCamposTabela>;

  TConnectionDefDriverParams = record
    DriverDefName: string;
    VendorLib: string;
  end;

  TConnectionDefParams = record
    ConnectionDefName: string;
    Server: string;
    Database: string;
    UserName: string;
    Password: string;
    LocalConnection: Boolean;
    DriverName: string;
    Driver: string;
    VendorLib: string;
  end;

  TConnectionDefPoolParams = record
    Pooled: Boolean;
    PoolMaximumItems: Integer;
    PoolCleanupTimeout: Integer;
    PoolExpireTimeout: Integer;
  end;

  TDefineParamConexao =  procedure(
      AParametrosConexao: TConnectionDefParams;
      AConnectionDefDriverParams: TConnectionDefDriverParams;
      AFDStanConnectionDef: IFDStanConnectionDef;
      AConnectionDefPoolParams: TConnectionDefPoolParams) of object;

  iConexaoPool = interface
    ['{2AE17385-38DF-4942-986E-634F2579AA4D}']
    function GetNomeConexao: string;
    function GetNomeLocal: string;
    function GetNomeBanco: string;
    function Getusuario: string;
    function GetSenha: string;
    function GetNomeDriver: string;
    function GetDriver: string;
    function GetBibliotecaEndereco: string;
    function SetarConexao(out AQuery: TFDQuery): iConexaoPool; overload;
    function IsConnected: Boolean;
    function PegarConexao: TFDConnection;
    property nomeconexao: string read GetNomeConexao;
    property NomeLocal: string read GetNomeLocal;
    property NomeBanco: string read GetNomeBanco;
    property Usuario: string read Getusuario;
    property Senha: string read  GetSenha;
    property NomeDriver: string read GetNomeDriver;
    property Driver: string read GetDriver;
    property BibliotecaEndereco: string read GetBibliotecaEndereco;
  end;

  iConexao = interface
    ['{2AE17385-38DF-4942-986E-634F2579AA4D}']
    function SetarConexao(out AQuery: TFDQuery): iConexao; overload;
    function IsConected: Boolean;
    function Commit: iConexao;
    function RollBack: iConexao;
    function AbreTransacao: iConexao;
    function PegarConexao: TFDConnection;
    function QueryCadastro: TFDQuery;
    function QueryConsulta: TFDQuery;
  end;

implementation

end.

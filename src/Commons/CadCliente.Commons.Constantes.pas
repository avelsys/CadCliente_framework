unit CadCliente.Commons.Constantes;

interface

uses
  System.AnsiStrings,
  IdSSLOpenSSL;

const
  csNOME_ARQUIVO_CONFIG_CONEXAO = 'config.ini';
  csBASE_DRIVER_ID              = 'BaseDriverID';
  csVENDOR_LIB                  = 'VendorLib';
  CHAVE                         = 'AngelysColetor';

  { Conexçao MSSQL}
  csNOME_CONEXAO                = 'MSSQL_CONNECTION';
  csHOSTNAME                    = 'localhost';
  csDATABASE                    = 'BdCadCliente';
  csPATABD                      = 'BD';
  csUSER                        = 'sa';
  csPASSWORD                    = '12936511';
  csDRIVER_CONEXAO              = 'MSSQL_CONN';
  csDRIVER                      = 'MSSQL';
  //csVENDOR_LIBRARY              = 'D:\projetos\Congrega\bin\lib';
  csVENDOR_LIBRARY              = '';

  { Constantes de nomeação de componentes do formulário}
  csVIEW_PAGINA_CONTROLE        = 'pgcControle';
  csVIEW_PAGINA_LISTAGEM        = 'tbsListagem';
  csVIEW_PAGINA_CADASTRO        = 'tbsCadastro';
  csVIEW_GRID_LISTAGEM          = 'dbgListagem';
  csVIEW_BOTAO_NOVO             = 'btnCadNovo';
  csVIEW_BOTAO_EDITAR           = 'btnCadEdiar';
  csVIEW_BOTAO_GRAVAR           = 'btnCadGravar';
  csVIEW_BOTAO_DELETAR          = 'btnCadDeletar';
  csVIEW_BOTAO_CANCELAR         = 'btnCadCancelar';
  csVIEW_BOTAO_SAIR             = 'btnCadSair';

  csVETOR_BOTOES_TELA:  array[0..5] of string = (csVIEW_BOTAO_NOVO
                                                ,csVIEW_BOTAO_EDITAR
                                                ,csVIEW_BOTAO_GRAVAR
                                                ,csVIEW_BOTAO_DELETAR
                                                ,csVIEW_BOTAO_CANCELAR
                                                ,csVIEW_BOTAO_SAIR);

  csVETOR_SHORTCUT_BOTOES:  array[0..5] of string = ('Ins'
                                                    ,'Enter'
                                                    ,'CTRL+S'
                                                    ,'Del'
                                                    ,'Esc'
                                                    ,'CTRL+X');

  csVETOR_CAPTION_BOTOES:  array[0..5] of string  = ('Novo'
                                                    ,'Editar'
                                                    ,'Gravar'
                                                    ,'Excluir'
                                                    ,'Cacenlar'
                                                    ,'Sair');

  csVETOR_HINT_BOTOES:  array[0..5] of string     = ('Cria Novo registro.'
                                                    ,'Editar registro selecionado.'
                                                    ,'Gravar inserções / edições do registro.'
                                                    ,'Excluir registro selecionado.'
                                                    ,'Cacenlar inserções / edições do registro.'
                                                    ,'Sair do formulário.');
type
  TBotoao_Tela = (enVIEW_BOTAO_NOVO     = 0
                 ,enVIEW_BOTAO_EDITAR   = 1
                 ,enVIEW_BOTAO_GRAVAR   = 2
                 ,enVIEW_BOTAO_DELETAR  = 3
                 ,enVIEW_BOTAO_CANCELAR = 4
                 ,enVIEW_BOTAO_SAIR     = 5 );



implementation


end.

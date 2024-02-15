unit CadCliente.Model.Main.Interfaces;

interface

uses
  CadCliente.View.BaseCadastro;

type
  TfrnViewBaseCadastroClass = class of TfrnViewBaseCadastro;
  IModelMain = interface
    ['{16D44033-DB6A-4BCC-BE9F-C317D00790C2}']
    /// <summary>
    ///   Realiza a chamada de formulários
    /// </summary>
    /// <param name="AFormClass">
    ///   Classe do Formulário à ser criado pela classe.
    /// </param>
    /// <returns>
    ///  retorna o objeto
    /// </returns>
    function ChamarFormulario(AFormClass: TfrnViewBaseCadastroClass):IModelMain;
  end;

implementation


end.

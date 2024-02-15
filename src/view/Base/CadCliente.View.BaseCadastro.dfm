inherited frnViewBaseCadastro: TfrnViewBaseCadastro
  Caption = 'Base Cadastro'
  ClientHeight = 382
  ClientWidth = 803
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  StyleElements = [seFont, seClient, seBorder]
  OnCreate = FormCreate
  ExplicitWidth = 819
  ExplicitHeight = 421
  TextHeight = 15
  object pnlTopo: TPanel
    AlignWithMargins = True
    Left = 677
    Top = 3
    Width = 123
    Height = 376
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object btnCadNovo: TButton
      AlignWithMargins = True
      Left = 3
      Top = 7
      Width = 117
      Height = 25
      Margins.Top = 7
      Align = alTop
      Caption = 'Novo'
      TabOrder = 0
    end
    object btnCadEdiar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 40
      Width = 117
      Height = 25
      Margins.Top = 5
      Align = alTop
      Caption = 'Editar'
      TabOrder = 1
    end
    object btnCadGravar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 73
      Width = 117
      Height = 25
      Margins.Top = 5
      Align = alTop
      Caption = 'Gravar'
      TabOrder = 2
    end
    object btnCadDeletar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 106
      Width = 117
      Height = 25
      Margins.Top = 5
      Align = alTop
      Caption = 'Deletar'
      TabOrder = 3
    end
    object btnCadCancelar: TButton
      AlignWithMargins = True
      Left = 3
      Top = 139
      Width = 117
      Height = 25
      Margins.Top = 5
      Align = alTop
      Caption = 'Cancelar'
      TabOrder = 4
    end
    object btnCadSair: TButton
      AlignWithMargins = True
      Left = 3
      Top = 344
      Width = 117
      Height = 25
      Margins.Top = 5
      Margins.Bottom = 7
      Align = alBottom
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 5
    end
  end
  object pnlBase: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 668
    Height = 376
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pgcControle: TPageControl
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 662
      Height = 370
      ActivePage = tbsListagem
      Align = alClient
      TabOrder = 0
      object tbsListagem: TTabSheet
        Caption = 'tbsListagem'
        TabVisible = False
        object dbgListagem: TDBGrid
          Left = 0
          Top = 0
          Width = 654
          Height = 360
          Align = alClient
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object tbsCadastro: TTabSheet
        Caption = 'tbsCadastro'
        ImageIndex = 1
        TabVisible = False
      end
    end
  end
end

object fmeViewBase: TfmeViewBase
  Left = 0
  Top = 0
  Width = 345
  Height = 189
  TabOrder = 0
  object gbxTitulo: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 10
    Width = 339
    Height = 176
    Margins.Top = 10
    Align = alClient
    Caption = 'Framebase'
    TabOrder = 0
    object pgcControleFrame: TPageControl
      AlignWithMargins = True
      Left = 5
      Top = 20
      Width = 329
      Height = 107
      ActivePage = tbsFrameListagem
      Align = alClient
      TabOrder = 0
      object tbsFrameListagem: TTabSheet
        Caption = 'tbsFrameListagem'
        TabVisible = False
        object dbgListagemFrame: TDBGrid
          Left = 0
          Top = 0
          Width = 321
          Height = 97
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
      end
      object tbsFrameCadastro: TTabSheet
        Caption = 'tbsFrameCadastro'
        ImageIndex = 1
        TabVisible = False
      end
    end
    object pnlSide: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 133
      Width = 329
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object nvtNavegador: TDBNavigator
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 309
        Height = 32
        Margins.Left = 10
        Margins.Right = 10
        VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
        Align = alClient
        TabOrder = 0
      end
    end
  end
end

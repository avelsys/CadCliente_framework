object frmViewMain: TfrmViewMain
  Left = 0
  Top = 0
  Caption = 'Sistema de Cadastro de Clientes'
  ClientHeight = 359
  ClientWidth = 730
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = mmMain
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 340
    Width = 730
    Height = 19
    Panels = <>
  end
  object mmMain: TMainMenu
    Left = 16
    Top = 8
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object Clientes1: TMenuItem
        Action = acCadCliente
        ShortCut = 16460
      end
    end
  end
  object aclMain: TActionList
    Left = 16
    Top = 72
    object acCadCliente: TAction
      Category = 'cadastro'
      Caption = 'Cadastro de &Clientes'
      ShortCut = 12355
      OnExecute = acCadClienteExecute
    end
  end
end

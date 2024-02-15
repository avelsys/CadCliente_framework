inherited frnViewCliente: TfrnViewCliente
  Caption = 'frnViewCliente'
  WindowState = wsMaximized
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited pnlTopo: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited pnlBase: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited pgcControle: TPageControl
      ActivePage = tbsCadastro
    end
  end
end

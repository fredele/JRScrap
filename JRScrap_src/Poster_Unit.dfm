object Poster_Frm: TPoster_Frm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Posters'
  ClientHeight = 366
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object CyPanel1: TCyPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 366
    Align = alClient
    TabOrder = 0
    Bevels = <
      item
      end>
    Degrade.FromColor = clWhite
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clBtnFace
    object Status_Lbl: TLabel
      Left = 15
      Top = 343
      Width = 35
      Height = 13
      Caption = 'Status:'
    end
    object Close: TButton
      Left = 529
      Top = 327
      Width = 93
      Height = 29
      Caption = 'Close'
      TabOrder = 0
      OnClick = CloseClick
    end
    object ScrollBox1: TScrollBox
      Left = 15
      Top = 16
      Width = 607
      Height = 288
      HorzScrollBar.Smooth = True
      HorzScrollBar.Size = 15
      BorderStyle = bsNone
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 1
      StyleElements = []
    end
  end
end

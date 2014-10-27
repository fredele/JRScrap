object OpenSub_Form: TOpenSub_Form
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  ClientHeight = 326
  ClientWidth = 876
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
  object StringGrid1: TStringGrid
    Left = 5
    Top = 12
    Width = 858
    Height = 264
    ColCount = 7
    DefaultColWidth = 200
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    TabOrder = 0
  end
  object Download: TButton
    Left = 788
    Top = 286
    Width = 75
    Height = 25
    Caption = 'Download'
    TabOrder = 1
    OnClick = DownloadClick
  end
end

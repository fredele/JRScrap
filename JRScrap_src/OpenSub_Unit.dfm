object OpenSub_Form: TOpenSub_Form
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Download - OpenSubtitles.org '
  ClientHeight = 326
  ClientWidth = 1100
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
    Width = 1085
    Height = 264
    ColCount = 7
    DefaultColWidth = 200
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Download: TButton
    Left = 942
    Top = 285
    Width = 148
    Height = 33
    Caption = 'Download'
    TabOrder = 1
    OnClick = DownloadClick
  end
end

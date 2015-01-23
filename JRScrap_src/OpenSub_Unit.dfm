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
  object CyPanel1: TCyPanel
    Left = 0
    Top = 0
    Width = 1100
    Height = 326
    Align = alClient
    TabOrder = 0
    Bevels = <
      item
      end>
    Degrade.FromColor = clWhite
    Degrade.Orientation = dgdAngle
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clSilver
    object Status_Lbl: TLabel
      Left = 14
      Top = 297
      Width = 43
      Height = 13
      Caption = 'Status:'
    end
    object Status_Lbl2: TLabel
      Left = 61
      Top = 297
      Width = 227
      Height = 13
      AutoSize = False
    end
    object Download: TButton
      Left = 942
      Top = 285
      Width = 148
      Height = 33
      Caption = 'Download'
      TabOrder = 0
      OnClick = DownloadClick
    end
    object StringGrid1: TStringGrid
      Left = 5
      Top = 15
      Width = 1085
      Height = 264
      ColCount = 8
      DefaultColWidth = 200
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 1
      OnDrawCell = StringGrid1DrawCell
    end
    object Hash_Search: TButton
      Left = 544
      Top = 285
      Width = 150
      Height = 29
      Caption = 'Hash Search'
      TabOrder = 2
      OnClick = Hash_SearchClick
    end
    object Imdb_Search: TButton
      Left = 709
      Top = 285
      Width = 150
      Height = 29
      Caption = 'Imdb Search'
      Enabled = False
      TabOrder = 3
      OnClick = Imdb_SearchClick
    end
  end
end

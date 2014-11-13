object Search_Frm: TSearch_Frm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Search'
  ClientHeight = 250
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 241
    Height = 13
    Caption = 'Select here the row  of the Movie to get tags from'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 31
    Top = 220
    Width = 41
    Height = 13
    Caption = 'Status:'
  end
  object Status_Lbl: TLabel
    Left = 87
    Top = 220
    Width = 504
    Height = 13
  end
  object Movie_Search_Grid: TStringGrid
    Left = 12
    Top = 30
    Width = 701
    Height = 167
    TabStop = False
    ColCount = 3
    DefaultColWidth = 100
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goFixedColClick]
    ParentFont = False
    TabOrder = 0
    OnClick = Movie_Search_GridClick
    RowHeights = (
      20)
  end
  object Close: TButton
    Left = 620
    Top = 209
    Width = 93
    Height = 29
    Caption = 'Close'
    TabOrder = 1
    OnClick = CloseClick
  end
end

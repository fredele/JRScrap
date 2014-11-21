object XML_Export_Frm: TXML_Export_Frm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Export'
  ClientHeight = 235
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object XSLSelect_Lbl: TLabel
    Left = 20
    Top = 14
    Width = 122
    Height = 13
    Caption = 'Select XSL rendering file :'
  end
  object Proc_Lbl: TLabel
    Left = 37
    Top = 164
    Width = 58
    Height = 13
    Caption = 'Processing :'
  end
  object Progress_Lbl: TLabel
    Left = 107
    Top = 164
    Width = 22
    Height = 13
    Caption = '0 / 0'
  end
  object Overview_Lbl: TLabel
    Left = 65
    Top = 109
    Width = 46
    Height = 13
    Caption = 'Overview'
  end
  object cyWebBrowser1: TcyWebBrowser
    Left = 51
    Top = 81
    Width = 113
    Height = 29
    ParentCustomHint = False
    TabStop = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
    OnDocumentComplete = cyWebBrowser1DocumentComplete
    ControlData = {
      4C000000AE0B0000FF0200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126201000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Generate_Btn: TButton
    Left = 448
    Top = 159
    Width = 91
    Height = 25
    Caption = 'Generate'
    TabOrder = 2
    OnClick = Generate_BtnClick
  end
  object Save_XML_Btn: TButton
    Left = 199
    Top = 195
    Width = 107
    Height = 25
    Caption = 'Save XML/XSL'
    Enabled = False
    TabOrder = 3
    OnClick = Save_XML_BtnClick
  end
  object Print_Btn: TButton
    Left = 448
    Top = 195
    Width = 92
    Height = 25
    Caption = 'Print'
    Enabled = False
    TabOrder = 4
    OnClick = Print_BtnClick
  end
  object Save_HTML: TButton
    Left = 331
    Top = 195
    Width = 101
    Height = 25
    Caption = 'Save HTML'
    Enabled = False
    TabOrder = 5
    OnClick = Save_HTMLClick
  end
  object XSL_File_List: TListBox
    Left = 37
    Top = 39
    Width = 502
    Height = 113
    ItemHeight = 13
    TabOrder = 0
  end
  object SaveDialog1: TSaveDialog
    Left = 133
    Top = 188
  end
end

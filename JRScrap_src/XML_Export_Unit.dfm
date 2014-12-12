object XML_Export_Frm: TXML_Export_Frm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Export'
  ClientHeight = 228
  ClientWidth = 328
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
  object CyPanel1: TCyPanel
    Left = 0
    Top = 0
    Width = 328
    Height = 228
    Align = alClient
    TabOrder = 0
    Bevels = <
      item
      end>
    Degrade.Balance = 60
    Degrade.FromColor = clWhite
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clSilver
    ExplicitLeft = 2
    ExplicitTop = 1
    ExplicitHeight = 204
    object Progress_Lbl: TLabel
      Left = 108
      Top = 201
      Width = 70
      Height = 13
      AutoSize = False
      Caption = '0 / 0'
    end
    object Overview_Lbl: TLabel
      Left = 65
      Top = 109
      Width = 46
      Height = 13
      Caption = 'Overview'
    end
    object Proc_Lbl: TLabel
      Left = 17
      Top = 201
      Width = 82
      Height = 33
      AutoSize = False
      Caption = 'Processing :'
    end
    object XSLSelect_Lbl: TLabel
      Left = 20
      Top = 14
      Width = 122
      Height = 13
      Caption = 'Select XSL rendering file :'
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
      TabOrder = 0
      OnDocumentComplete = cyWebBrowser1DocumentComplete
      ControlData = {
        4C000000AE0B0000FF0200000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126201000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object Generate_Btn: TButton
      Left = 209
      Top = 133
      Width = 97
      Height = 25
      Caption = 'Generate'
      TabOrder = 1
      OnClick = Generate_BtnClick
    end
    object Print_Btn: TButton
      Left = 209
      Top = 164
      Width = 97
      Height = 25
      Caption = 'Print'
      Enabled = False
      TabOrder = 2
      OnClick = Print_BtnClick
    end
    object Save_HTML: TButton
      Left = 113
      Top = 164
      Width = 93
      Height = 25
      Caption = 'Save HTML'
      Enabled = False
      TabOrder = 3
      OnClick = Save_HTMLClick
    end
    object Save_XML_Btn: TButton
      Left = 12
      Top = 164
      Width = 99
      Height = 25
      Caption = 'Save XML/XSL'
      Enabled = False
      TabOrder = 4
      OnClick = Save_XML_BtnClick
    end
    object XSL_File_List: TListBox
      Left = 17
      Top = 14
      Width = 289
      Height = 113
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object SaveDialog1: TSaveDialog
    Left = 241
    Top = 61
  end
end

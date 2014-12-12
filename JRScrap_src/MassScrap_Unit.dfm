object MassScrap_Frm: TMassScrap_Frm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'JRMoviedB Mass Scrap'
  ClientHeight = 225
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CyPanel1: TCyPanel
    Left = 0
    Top = 0
    Width = 400
    Height = 225
    Align = alClient
    TabOrder = 0
    Bevels = <
      item
      end>
    Degrade.Balance = 70
    Degrade.FromColor = clWhite
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clSilver
    object Film_Lbl: TLabel
      Left = 192
      Top = 103
      Width = 3
      Height = 13
    end
    object Label1: TLabel
      Left = 108
      Top = 84
      Width = 49
      Height = 13
      Caption = 'Progress :'
    end
    object Label2: TLabel
      Left = 108
      Top = 103
      Width = 35
      Height = 13
      Caption = 'Media :'
    end
    object progresscount_Lbl: TLabel
      Left = 195
      Top = 84
      Width = 16
      Height = 13
      Caption = '0/0'
    end
    object Button2: TButton
      Left = 17
      Top = 176
      Width = 356
      Height = 26
      Caption = 'Go !'
      TabOrder = 0
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 19
      Width = 372
      Height = 17
      Caption = 'Scrap first Media found if API ID is missing'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object Picture_Rec_Chk: TCheckBox
      Left = 24
      Top = 45
      Width = 368
      Height = 17
      Caption = 'Record the picture'
      TabOrder = 2
      OnClick = Picture_Rec_ChkClick
    end
    object ProgressBar1: TProgressBar
      Left = 17
      Top = 137
      Width = 356
      Height = 17
      TabOrder = 3
    end
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 342
    Top = 87
  end
end

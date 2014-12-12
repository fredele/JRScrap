object SubDB_Frm: TSubDB_Frm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'SubDB'
  ClientHeight = 149
  ClientWidth = 200
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
  object CyPanel1: TCyPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 149
    Align = alClient
    TabOrder = 0
    Bevels = <
      item
      end>
    Degrade.AngleDegree = 20
    Degrade.Balance = 80
    Degrade.FromColor = clWhite
    Degrade.SpeedPercent = 100
    Degrade.ToColor = clSilver
    ExplicitLeft = 51
    ExplicitTop = 106
    ExplicitWidth = 185
    ExplicitHeight = 41
    object Status_Lbl: TLabel
      Left = 9
      Top = 133
      Width = 182
      Height = 13
      AutoSize = False
      Caption = 'Status :'
    end
    object Download_Btn: TButton
      Left = 89
      Top = 100
      Width = 102
      Height = 27
      Caption = 'Download'
      Enabled = False
      TabOrder = 0
      OnClick = Download_BtnClick
    end
    object ListBox1: TListBox
      Left = 9
      Top = 17
      Width = 182
      Height = 77
      Style = lbOwnerDrawFixed
      TabOrder = 1
      OnDrawItem = ListBox1DrawItem
    end
  end
end

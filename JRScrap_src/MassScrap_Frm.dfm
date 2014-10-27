object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'JRMoviedB Mass Scrap'
  ClientHeight = 478
  ClientWidth = 389
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
  object progresscount_Lbl: TLabel
    Left = 195
    Top = 68
    Width = 16
    Height = 13
    Caption = '0/0'
  end
  object Label2: TLabel
    Left = 108
    Top = 103
    Width = 65
    Height = 13
    Caption = 'Current Film :'
  end
  object Film_Lbl: TLabel
    Left = 192
    Top = 103
    Width = 3
    Height = 13
  end
  object Label1: TLabel
    Left = 108
    Top = 68
    Width = 49
    Height = 13
    Caption = 'Progress :'
  end
  object select_lbl: TLabel
    Left = 115
    Top = 216
    Width = 128
    Height = 13
    Caption = 'Select here fields to save :'
  end
  object ProgressBar1: TProgressBar
    Left = 17
    Top = 137
    Width = 356
    Height = 17
    TabOrder = 0
  end
  object Button2: TButton
    Left = 17
    Top = 175
    Width = 356
    Height = 26
    Caption = 'Go !'
    TabOrder = 1
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 19
    Width = 372
    Height = 17
    Caption = 'Scrap first Movie found if IMBD ID is missing'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object MassScrap_Field_list: TCheckListBox
    Left = 17
    Top = 243
    Width = 356
    Height = 154
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    Items.Strings = (
      'Picture'
      'Title'
      'Original Title'
      'release date'
      'imdb ID'
      'Overview'
      'Vote Average'
      'Production Company'
      'Genres'
      'Keywords'
      'Cast'
      'Crew')
    ParentFont = False
    TabOrder = 3
    OnClick = MassScrap_Field_listClick
  end
  object Button1: TButton
    Left = 336
    Top = 207
    Width = 37
    Height = 25
    Caption = '...'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Timer1: TTimer
    Interval = 400
    OnTimer = Timer1Timer
    Left = 278
    Top = 10
  end
end

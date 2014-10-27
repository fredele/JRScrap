object Themoviedb: TThemoviedb
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderWidth = 5
  Caption = 'JRScrap '
  ClientHeight = 879
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 201
    Top = 423
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Panel1: TPanel
    Left = 392
    Top = 0
    Width = 736
    Height = 847
    Align = alRight
    Caption = 'Panel1'
    TabOrder = 0
    object Panel5: TPanel
      Left = 1
      Top = 25
      Width = 734
      Height = 289
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel5'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Label12: TLabel
        Left = 12
        Top = 10
        Width = 132
        Height = 13
        Caption = 'Correct the Movie title here'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 12
        Top = 229
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
      object View_Btn: TButton
        Left = -1
        Top = 260
        Width = 732
        Height = 25
        Hint = 'Click to search and view the Content of TheMoviedB.org only'
        Caption = 'Retrieve this Media'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ImageIndex = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = View_BtnClick
      end
      object Movie_Search_Grid: TStringGrid
        Left = 5
        Top = 104
        Width = 721
        Height = 119
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
        TabOrder = 1
        OnClick = Movie_Search_GridClick
        RowHeights = (
          20)
      end
      object Search_Btn: TButton
        Left = 0
        Top = 71
        Width = 733
        Height = 25
        Hint = 
          'Search  this Movie info on TheMoviedB.org and get a list of poss' +
          'ible Movies'
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Caption = 'Search this Media'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Calibri'
        Font.Style = [fsBold]
        ImageAlignment = iaRight
        ImageIndex = 0
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Search_BtnClick
      end
      object SearchEdit: TmnEdit
        Left = 7
        Top = 32
        Width = 717
        Height = 33
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        ParentCustomHint = False
        TabStop = False
        Alignment = taRightJustify
        BorderStyle = bsNone
        Ctl3D = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -24
        Font.Name = 'Calibri'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 3
        OnChange = SearchEditChange
      end
      object search_byimdb: TRadioButton
        Left = 553
        Top = 234
        Width = 70
        Height = 17
        Caption = 'By ImdB/TvdB Id'
        TabOrder = 4
        OnClick = search_byimdbClick
      end
      object search_byname: TRadioButton
        Left = 517
        Top = 6
        Width = 121
        Height = 17
        Caption = 'By Title'
        Checked = True
        TabOrder = 5
        TabStop = True
        OnClick = search_bynameClick
      end
      object Imdb_search: TEdit
        Left = 634
        Top = 229
        Width = 91
        Height = 21
        TabStop = False
        BorderStyle = bsNone
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Calibri'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnEnter = Imdb_searchEnter
      end
    end
    object Write_Btn: TButton
      Left = 1
      Top = 821
      Width = 734
      Height = 25
      Align = alBottom
      Caption = 'Write this !'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Write_BtnClick
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 734
      Height = 24
      Align = alTop
      TabOrder = 2
      object Label5: TLabel
        Left = 12
        Top = 5
        Width = 91
        Height = 13
        Caption = 'Select service here'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object TheMoviedB_rd: TRadioButton
        Left = 452
        Top = 1
        Width = 143
        Height = 17
        Caption = 'TheMoviedB.org (Movies)'
        TabOrder = 0
        OnClick = TheMoviedB_rdClick
      end
      object TVdb_Rd: TRadioButton
        Left = 614
        Top = 5
        Width = 127
        Height = 16
        Caption = 'TVdb.com (Series)'
        TabOrder = 1
        OnClick = TheMoviedB_rdClick
      end
    end
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 314
      Width = 734
      Height = 507
      Align = alClient
      TabOrder = 3
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 713
        Height = 510
        ActivePage = TabSheet_Single_Movie
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object TabSheet_Single_Movie: TTabSheet
          Caption = 'Movie Info'
          object Panel2: TPanel
            Left = 0
            Top = 0
            Width = 705
            Height = 482
            Align = alClient
            BevelOuter = bvNone
            Caption = 'Panel2'
            ParentBackground = False
            TabOrder = 0
            object Label3: TLabel
              Left = 468
              Top = 112
              Width = 42
              Height = 13
              Caption = 'Season :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 578
              Top = 112
              Width = 44
              Height = 13
              Caption = 'Episode :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Title_Chk: TCheckBox
              Left = 259
              Top = 13
              Width = 113
              Height = 17
              TabStop = False
              Caption = 'Title :'
              TabOrder = 0
            end
            object Picture_Chk: TCheckBox
              Left = 14
              Top = 13
              Width = 201
              Height = 17
              TabStop = False
              Caption = 'Picture :'
              TabOrder = 1
            end
            object Original_Title_Chk: TCheckBox
              Left = 259
              Top = 46
              Width = 113
              Height = 17
              TabStop = False
              Caption = 'Original Title :'
              TabOrder = 2
            end
            object Overview_Chk: TCheckBox
              Left = 259
              Top = 111
              Width = 155
              Height = 17
              TabStop = False
              Caption = 'Overview :'
              TabOrder = 3
            end
            object release_date_Chk: TCheckBox
              Left = 259
              Top = 81
              Width = 153
              Height = 17
              TabStop = False
              Caption = 'Release date :'
              TabOrder = 4
            end
            object API_id_chk: TCheckBox
              Left = 534
              Top = 82
              Width = 100
              Height = 17
              TabStop = False
              Caption = 'imdb/Tvdb ID :'
              TabOrder = 5
            end
            object API_id_Ed: TEdit
              Left = 612
              Top = 77
              Width = 84
              Height = 21
              TabStop = False
              BorderStyle = bsNone
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              OnChange = API_id_EdChange
              OnKeyPress = API_id_EdKeyPress
            end
            object Release_date_Ed: TEdit
              Left = 373
              Top = 76
              Width = 92
              Height = 21
              TabStop = False
              BorderStyle = bsNone
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnKeyPress = Release_date_EdKeyPress
            end
            object MemoOverview: TMemo
              Left = 257
              Top = 133
              Width = 436
              Height = 178
              Hint = 'Modify the Overview here'
              TabStop = False
              BorderStyle = bsNone
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ScrollBars = ssVertical
              ShowHint = True
              TabOrder = 8
              OnKeyPress = MemoOverviewKeyPress
            end
            object Vote_Average_Chk: TCheckBox
              Left = 400
              Top = 322
              Width = 95
              Height = 17
              TabStop = False
              Caption = 'Vote Average :'
              TabOrder = 9
            end
            object Keywords_Chk: TCheckBox
              Left = 473
              Top = 348
              Width = 224
              Height = 17
              TabStop = False
              Caption = 'Keywords :'
              TabOrder = 10
            end
            object Production_Comp_Chk: TCheckBox
              Left = 6
              Top = 347
              Width = 206
              Height = 21
              TabStop = False
              Caption = 'Production company :'
              TabOrder = 11
            end
            object Genres_Chk: TCheckBox
              Left = 239
              Top = 347
              Width = 224
              Height = 17
              TabStop = False
              Caption = 'Genres :'
              TabOrder = 12
            end
            object Genre_ListBox: TListBox
              Left = 239
              Top = 368
              Width = 220
              Height = 106
              TabStop = False
              BorderStyle = bsNone
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ItemHeight = 19
              ParentFont = False
              ParentShowHint = False
              PopupMenu = Genres_Pop
              ShowHint = False
              Sorted = True
              TabOrder = 13
            end
            object Production_Company_ListBox: TListBox
              Left = 6
              Top = 368
              Width = 220
              Height = 107
              TabStop = False
              BorderStyle = bsNone
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ItemHeight = 19
              ParentFont = False
              PopupMenu = Production_Pop
              Sorted = True
              TabOrder = 14
            end
            object Keywords_List: TListBox
              Left = 473
              Top = 367
              Width = 220
              Height = 108
              TabStop = False
              BorderStyle = bsNone
              Color = clWhite
              ExtendedSelect = False
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ItemHeight = 19
              ParentFont = False
              PopupMenu = Keyword_Pop
              Sorted = True
              TabOrder = 15
            end
            object Picture_Panel: TPanel
              Left = 19
              Top = 36
              Width = 230
              Height = 305
              BevelOuter = bvNone
              Ctl3D = True
              ParentCtl3D = False
              TabOrder = 16
              object Picture_Img: TImage
                Left = 0
                Top = 0
                Width = 230
                Height = 305
                Hint = 'Drag&Drop Image here'
                Margins.Left = 5
                Margins.Top = 5
                Margins.Right = 5
                Margins.Bottom = 5
                ParentCustomHint = False
                Align = alClient
                ParentShowHint = False
                Proportional = True
                ShowHint = True
                ExplicitLeft = 2
                ExplicitTop = 2
              end
            end
            object Original_title_Ed: TmnEdit
              Left = 374
              Top = 40
              Width = 322
              Height = 27
              TabStop = False
              Alignment = taRightJustify
              AutoSize = False
              BorderStyle = bsNone
              Ctl3D = True
              Font.Charset = ANSI_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Calibri'
              Font.Style = []
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 17
              OnKeyPress = Original_title_EdKeyPress
            end
            object Title_Ed: TmnEdit
              Left = 374
              Top = 7
              Width = 322
              Height = 27
              TabStop = False
              Align = alCustom
              Alignment = taRightJustify
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -21
              Font.Name = 'Calibri'
              Font.Style = []
              ParentFont = False
              TabOrder = 18
              OnKeyPress = Title_EdKeyPress
            end
            object Star_Panel: TStar_Panel
              Left = 494
              Top = 322
              Width = 185
              Height = 22
              TabOrder = 19
            end
            object Season_Spin_W: TSpinEdit
              Left = 532
              Top = 109
              Width = 40
              Height = 22
              MaxValue = 30
              MinValue = 0
              TabOrder = 20
              Value = 1
              OnChange = Season_Spin_WChange
              OnEnter = Season_Spin_WEnter
              OnExit = Season_Spin_WExit
            end
            object Episode_Spin_W: TSpinEdit
              Left = 656
              Top = 109
              Width = 40
              Height = 22
              MaxValue = 30
              MinValue = 0
              TabOrder = 21
              Value = 1
              OnChange = Episode_Spin_WChange
              OnEnter = Episode_Spin_WEnter
              OnExit = Episode_Spin_WExit
            end
            object Subtitle_Btn: TButton
              Left = 264
              Top = 317
              Width = 119
              Height = 23
              Caption = 'Subtitle'
              TabOrder = 22
              OnClick = Subtitle_BtnClick
            end
          end
        end
        object TabSheet_Single_Movie_Add: TTabSheet
          Caption = 'Additionnal Info'
          ImageIndex = 1
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 705
            Height = 482
            Align = alClient
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            object Cast_Chk: TCheckBox
              Left = 12
              Top = 17
              Width = 116
              Height = 17
              Caption = 'Cast :'
              TabOrder = 0
            end
            object Cast_Grid: TStringGrid
              Left = 15
              Top = 36
              Width = 698
              Height = 196
              ColCount = 3
              DefaultRowHeight = 20
              FixedCols = 0
              RowCount = 1
              FixedRows = 0
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
              TabOrder = 1
              ColWidths = (
                64
                64
                66)
            end
            object Crew_Chk: TCheckBox
              Left = 12
              Top = 242
              Width = 102
              Height = 17
              Caption = 'Crew :'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object Crew_Grid: TStringGrid
              Left = 15
              Top = 265
              Width = 699
              Height = 200
              ColCount = 4
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
              Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
              ParentFont = False
              TabOrder = 3
              RowHeights = (
                20)
            end
          end
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 847
    Align = alClient
    Caption = 'Panel3'
    TabOrder = 1
    object Movie_Browser: TStringGrid
      Left = 1
      Top = 28
      Width = 390
      Height = 818
      Align = alClient
      ColCount = 14
      FixedCols = 0
      RowCount = 2
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goFixedRowClick]
      ParentFont = False
      PopupMenu = Movie_Browser_Pop
      TabOrder = 0
      OnClick = Movie_BrowserClick
      OnDrawCell = Movie_BrowserDrawCell
      OnFixedCellClick = Movie_BrowserFixedCellClick
      OnMouseDown = Movie_BrowserMouseDown
      OnMouseUp = Movie_BrowserMouseUp
      ColWidths = (
        64
        135
        64
        64
        64
        64
        64
        64
        64
        64
        64
        64
        64
        64)
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 390
      Height = 27
      Align = alTop
      TabOrder = 1
    end
  end
  object ComboBox1: TComboBox
    Left = 0
    Top = 0
    Width = 392
    Height = 21
    Align = alClient
    Style = csDropDownList
    TabOrder = 2
    OnChange = ComboBox1Change
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 847
    Width = 1128
    Height = 32
    Panels = <
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 170
      end
      item
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Width = 620
      end
      item
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        Text = '          '
        Width = 50
      end>
  end
  object MainMenu1: TMainMenu
    AutoHotkeys = maManual
    Left = 26
    Top = 146
    object Configure1: TMenuItem
      Caption = 'Menu'
      object scrapall1: TMenuItem
        Caption = 'Scrap Medias from this line'
        OnClick = scrapall1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Select1: TMenuItem
        Caption = 'Select'
        object All1: TMenuItem
          Caption = 'All'
          ShortCut = 16449
          OnClick = All1Click
        end
        object None1: TMenuItem
          Caption = 'None'
          ShortCut = 16462
          OnClick = None1Click
        end
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object SelectQuerylanguage: TMenuItem
        Caption = 'Select Query language'
      end
      object Gotofolder: TMenuItem
        Caption = 'Go to current Folder'
        ShortCut = 16454
        OnClick = GotofolderClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object SelectStyle: TMenuItem
        Caption = 'Select Style'
      end
      object Selectlanguage1: TMenuItem
        Caption = 'Select language'
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Lock1: TMenuItem
        Caption = 'Lock'
        object All2: TMenuItem
          Caption = 'All'
          OnClick = All2Click
        end
        object None2: TMenuItem
          Caption = 'None'
          OnClick = None2Click
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object EnterKeyforthemmoviedbAPI1: TMenuItem
        Caption = 'Configure'
        object WriteXMLsideCar1: TMenuItem
          Caption = 'Write XML side Car'
          Checked = True
          OnClick = WriteXMLsideCar1Click
        end
        object SeeLogFile1: TMenuItem
          Caption = 'Log'
          object OpenFolder1: TMenuItem
            Caption = 'Open Folder'
            OnClick = OpenFolder1Click
          end
          object EraseHistory1: TMenuItem
            Caption = 'Erase History'
            OnClick = EraseHistory1Click
          end
        end
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Close1: TMenuItem
        Caption = 'Quit'
        ShortCut = 16465
        OnClick = Close1Click
      end
    end
    object Help: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
      object Helppage1: TMenuItem
        Caption = 'JRScrap Help'
        OnClick = Helppage1Click
      end
    end
  end
  object Keyword_Pop: TPopupMenu
    Left = 978
    Top = 738
    object Add1: TMenuItem
      Caption = 'Add'
      OnClick = Add1Click
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
  object Production_Pop: TPopupMenu
    Left = 473
    Top = 708
    object Delete: TMenuItem
      Caption = 'Add'
      OnClick = DeleteClick
    end
    object Delete2: TMenuItem
      Caption = 'Delete'
      OnClick = Delete2Click
    end
  end
  object Genres_Pop: TPopupMenu
    Left = 680
    Top = 717
    object Add2: TMenuItem
      Caption = 'Add'
      OnClick = Add2Click
    end
    object Delete3: TMenuItem
      Caption = 'Delete'
      OnClick = Delete3Click
    end
  end
  object Movie_Browser_Pop: TPopupMenu
    Left = 119
    Top = 145
    object Eraseallinfo1: TMenuItem
      Caption = 'Erase all tags'
      OnClick = Eraseallinfo1Click
    end
    object Dossiercourant1: TMenuItem
      Caption = 'Go to current Folder'
      OnClick = Dossiercourant1Click
    end
  end
  object MCAutomation: TMCAutomation
    AutoConnect = True
    ConnectKind = ckRunningOrNew
    Left = 210
    Top = 144
  end
end

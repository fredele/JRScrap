// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit Search_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Generic_Search_Unit, Vcl.ExtCtrls, cyBasePanel, cyPanel;

type
  TSearch_Frm = class(TForm)
    CyPanel1: TCyPanel;
    Close: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Movie_Search_Grid: TStringGrid;
    Status_Lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Movie_Search_GridClick(Sender: TObject);
    constructor Create(AOwner: TComponent; search: TGeneric_Search);

    constructor Create_Param(AOwner: TComponent; param: string;
      search: TGeneric_Search);
    procedure CloseClick(Sender: TObject);
  private
    FService: string;
  public
    { Public declarations }
  end;

var
  Search_Frm: TSearch_Frm;
  Fsearch: TGeneric_Search;

implementation

uses
  TheMoviedB_Unit, JRScrap_Unit, translateJRStyle_Unit;
{$R *.dfm}

procedure TSearch_Frm.CloseClick(Sender: TObject);
begin
  modalresult := mrOK;
end;

constructor TSearch_Frm.Create_Param(AOwner: TComponent; param: string;
  search: TGeneric_Search);
begin
  inherited Create(AOwner);
  Fsearch := search;
  FService := param;
end;

constructor TSearch_Frm.Create(AOwner: TComponent; search: TGeneric_Search);
begin
  inherited Create(AOwner);
  Fsearch := search;

end;

procedure TSearch_Frm.FormActivate(Sender: TObject);
begin
  self.Top := JRScrap_frm.Top + round((JRScrap_frm.Height - self.Height) / 2);
  self.Left := JRScrap_frm.Left + round((JRScrap_frm.Width - self.Width) / 2);

  self.Close.Caption := Translate_String_JRStyle('Close',
    JRScrap_frm.FCurrentLang_GUI);
  self.Status_Lbl.Caption := Translate_String_JRStyle('Searching ...',
    JRScrap_frm.FCurrentLang_GUI);
  self.Label1.Caption := Translate_String_JRStyle
    ('Select here the row  of the Movie to get tags from',
    JRScrap_frm.FCurrentLang_GUI);
  self.Caption := Translate_String_JRStyle('Search',
    JRScrap_frm.FCurrentLang_GUI);
  self.Movie_Search_Grid.ColWidths[0] := 515;
  self.Movie_Search_Grid.ColWidths[1] := 165;
  self.Movie_Search_Grid.ColWidths[2] := 0;

  if ((JRScrap_frm.TheMoviedB_Btn.down = true) and
    (JRScrap_frm.Movie_Btn.down = true)) then
    Fsearch.SearchFiles(JRScrap_frm.Name_Ed.Text);

  if ((JRScrap_frm.TheMoviedB_Btn.down = true) and
    (JRScrap_frm.Serie_Btn.down = true)) then
    Fsearch.SearchFiles(JRScrap_frm.Serie_Name_ed.Text);

  if ((JRScrap_frm.tvdb_Btn.down = true) and (JRScrap_frm.Serie_Btn.down = true))
  then
    Fsearch.SearchFiles(JRScrap_frm.Serie_Name_ed.Text);

end;

procedure TSearch_Frm.Movie_Search_GridClick(Sender: TObject);
begin

  if JRScrap_frm.Movie_Btn.down = true then
  begin
    if JRScrap_frm.TheMoviedB_Btn.down = true then
    begin
      TheMoviedB_Ins.tmdb_id := self.Movie_Search_Grid.Cells
        [2, self.Movie_Search_Grid.row];
      TheMoviedB_Ins.TheMoviedB_Movie_ID_Search_Proc;
    end;
  end;

  if JRScrap_frm.Serie_Btn.down = true then
  begin

    if JRScrap_frm.tvdb_Btn.down = true then
    begin
      TtvdB_Ins.tvdb_id := self.Movie_Search_Grid.Cells
        [2, self.Movie_Search_Grid.row];
      TtvdB_Ins.TheTVDB_ID_Search_Proc;
    end;

    if JRScrap_frm.TheMoviedB_Btn.down = true then
    begin
      TheMoviedB_Ins.tmdb_id := self.Movie_Search_Grid.Cells
        [2, self.Movie_Search_Grid.row];
      TheMoviedB_Ins.TheMoviedB_Serie_Se_Ep_ID_Search_Proc;
    end;

  end;

  JRScrap_frm.ClearAll;
end;

end.

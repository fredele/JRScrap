unit Search_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  Generic_Search_Unit;

type
  TSearch_Frm = class(TForm)
    Label1: TLabel;
    Close: TButton;
    Movie_Search_Grid: TStringGrid;
    Label2: TLabel;
    Status_Lbl: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Movie_Search_GridClick(Sender: TObject);
    constructor Create(AOwner: TComponent; search: TGeneric_Search);
    procedure CloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Search_Frm: TSearch_Frm;
  Fsearch: TGeneric_Search;

implementation

uses
  TheMoviedB_Unit, JRScrap_Unit ,  translateJRStyle_Unit;
{$R *.dfm}

procedure TSearch_Frm.CloseClick(Sender: TObject);
begin
modalresult := mrOK ;
end;

constructor TSearch_Frm.Create(AOwner: TComponent; search: TGeneric_Search);
begin
  inherited Create(AOwner);
  Fsearch := search;

end;

procedure TSearch_Frm.FormActivate(Sender: TObject);
begin
  self.Close.Caption := Translate_String_JRStyle('Close', JRScrap_frm.FCurrentLang);
  self.Status_Lbl.Caption := Translate_String_JRStyle('Searching ...', JRScrap_frm.FCurrentLang);
  self.Movie_Search_Grid.ColWidths[0] := 515;
  self.Movie_Search_Grid.ColWidths[1] := 165;
  self.Movie_Search_Grid.ColWidths[2] := 0;

  if JRScrap_Frm.TheMoviedB_rd.down = true then
     Fsearch.SearchFiles(JRScrap_Frm.Name_Ed.Text);

  if JRScrap_Frm.tvdb_rd.down = true then
     Fsearch.SearchFiles(JRScrap_Frm.Serie_title_ed.Text);

end;

procedure TSearch_Frm.Movie_Search_GridClick(Sender: TObject);
begin

  JRScrap_Frm.ClearAll;

  if JRScrap_Frm.TheMoviedB_rd.down= true then
  begin
  TheMoviedB_Ins.tmdb_id := self.Movie_Search_Grid.Cells[2, self.Movie_Search_Grid.row];
  TheMoviedB_Ins.TheMoviedB_ID_Search_Proc;
  end;

  if JRScrap_Frm.TVdb_Rd.down = true then
  begin
  TtvdB_Ins.tvdb_id := self.Movie_Search_Grid.Cells [2, self.Movie_Search_Grid.row];
  TtvdB_Ins.TheTVDB_ID_Search_Proc;
  end;


end;

end.

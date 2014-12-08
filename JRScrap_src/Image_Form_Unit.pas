// This file is part of th JRScrap project.
// Licence : GPL v 3
// Website : https://github.com/fredele/JRScrap/
// Year : 2014
// Author : frederic klieber

unit Image_Form_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TImage_Form = class(TForm)
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Image_Form: TImage_Form;

implementation

{$R *.dfm}

end.

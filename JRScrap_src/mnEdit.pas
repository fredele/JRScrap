unit mnEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Windows;

type
  TmnEdit = class(TEdit)
  private
    FAlignment: TAlignment;
    procedure SetAlignment(Value: TAlignment);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    property Alignment: TAlignment read FAlignment write SetAlignment;
  end;

procedure Register;

implementation

{ TmnEdit }

procedure TmnEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array [TAlignment] of LongWord = (ES_Left, ES_Right, ES_Center);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TmnEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure Register;
begin
  RegisterComponents('mnEdit', [TmnEdit]);
end;

end.

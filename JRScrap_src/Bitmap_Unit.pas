unit Bitmap_Unit;

interface

uses
  Vcl.ExtCtrls, Winapi.Windows, Vcl.Controls, Vcl.Graphics;

type

  pRGBQuadArray = ^TRGBQuadArray;
  TRGBQuadArray = ARRAY [0 .. 0] OF TRGBQuad;

procedure SetImageAlpha(Image: TImage; Alpha: Byte);

implementation

procedure SetImageAlpha(Image: TImage; Alpha: Byte);
var
  pscanLine32, pscanLine32_src: pRGBQuadArray;
  nScanLineCount, nPixelCount: Integer;
  BMP1, BMP2: TBitMap;
  WasBitMap: Boolean;
begin
  if assigned(Image.Picture) then
  begin
    // check if another graphictype than an bitmap is assigned
    // don't check Assigned(Image.Picture.Bitmap) which will return always true
    // since a bitmap is created if needed and the graphic will be discared
    WasBitMap := Not assigned(Image.Picture.Graphic);
    if not WasBitMap then
    begin // let's create a new bitmap from the graphic
      BMP1 := TBitMap.Create;
      BMP1.Assign(Image.Picture.Graphic);
    end
    else
      BMP1 := Image.Picture.Bitmap; // take the bitmap

    BMP1.PixelFormat := pf32Bit;

    // we need a copy since setting Alphaformat:= afDefined will clear the Bitmap
    BMP2 := TBitMap.Create;
    BMP2.Assign(BMP1);

    BMP1.Alphaformat := afDefined;

  end;
  for nScanLineCount := 0 to BMP1.Height - 1 do
  begin
    pscanLine32 := BMP1.Scanline[nScanLineCount];
    pscanLine32_src := BMP2.Scanline[nScanLineCount];
    for nPixelCount := 0 to BMP1.Width - 1 do
    begin
      pscanLine32[nPixelCount].rgbReserved := Alpha;
      pscanLine32[nPixelCount].rgbBlue :=
        round(pscanLine32_src[nPixelCount].rgbBlue * Alpha / 255);
      pscanLine32[nPixelCount].rgbRed :=
        round(pscanLine32_src[nPixelCount].rgbRed * Alpha / 255);
      pscanLine32[nPixelCount].rgbGreen :=
        round(pscanLine32_src[nPixelCount].rgbGreen * Alpha / 255);
    end;
  end;
  If not WasBitMap then
  begin // assign and free Bitmap if we had to create it
    Image.Picture.Assign(BMP1);
    BMP1.Free;
  end;
  BMP2.Free; // free the copy
end;

end.

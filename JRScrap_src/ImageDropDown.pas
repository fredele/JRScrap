// This file is part of th JRScrap project.
// Licence : GPL v 3
// Website : https://github.com/fredele/JRScrap/
// Year : 2014
// Author : frederic klieber

Unit ImageDropDown;

Interface

Uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Jpeg, pngimage, ShellAPI, ExtCtrls;

Type
  TFormatIMG = Set Of (fiJPG, fiBMP, fiPNG);

  TImageDropDown<T: TGraphic, Constructor> = Class
  Private
    originalImageWindowProc: TWndMethod;
    FImage: TImage;
    FPanel: TPanel;
    FIMG: T;
    FFormatIMG: TFormatIMG;
    FFileName: String;
    FOnBeforeLoadImg, FOnAfterLoadImg: TNotifyEvent;
    Procedure ImageDrop(Var Msg: TWMDROPFILES);
  Public
    Procedure ImageWindowProc(Var Msg: TMessage);
    Procedure LoadIMG(Const sImgFileName: String);
    Procedure ClearIMG;
    Procedure SelectIMG;
    Constructor Create(AImage: TImage; APanel: TPanel);
    Destructor Destroy; Override;
    Property IMG: T Read FIMG Write FIMG;
    Property FormatIMG: TFormatIMG Read FFormatIMG Write FFormatIMG;
    Property FileName: String Read FFileName;
    Property OnBeforeLoadImg: TNotifyEvent Read FOnBeforeLoadImg
      Write FOnBeforeLoadImg;
    Property OnAfterLoadImg: TNotifyEvent Read FOnAfterLoadImg
      Write FOnAfterLoadImg;
  End;

Resourcestring
  lng_CannotLoadLotOfImg =
    'Vous ne pouvez pas déposer plusieurs images en même temps.';
  lng_AllImages = 'Tous les formats images supportés';
  lng_JPGImages = 'Images JPEG';
  lng_BMPImages = 'Images BMP';
  lng_PNGImages = 'images PNG';
  lng_FileExtIsBad = 'file extension is incorrect';

Implementation

Procedure TImageDropDown<T>.ClearIMG;
Begin
  FImage.Picture.Assign(NIL);
  FreeAndNil(FIMG);
End;

Procedure TImageDropDown<T>.LoadIMG(Const sImgFileName: String);
Var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
  Png: TPngImage;
  FileExt: String;
Begin
  Try
    If Assigned(OnBeforeLoadImg) Then
      OnBeforeLoadImg(Self);

    FileExt := ExtractFileExt(sImgFileName);
    If ((FileExt = '.jpg') Or (FileExt = '.jpeg') Or (FileExt = '.JPG')) And
      (fiJPG In FormatIMG) Then
    Begin
      Jpg := TJPEGImage.Create;
      Try
        Jpg.LoadFromFile(sImgFileName);

        If Not Assigned(IMG) Then
          FIMG := T.Create;

        // cannot assign jpg to png directly
        If FIMG.ClassNameIs('TPngImage') Then
        Begin
          Bmp := TBitmap.Create;
          Try
            Bmp.Assign(Jpg);
            FIMG.Assign(Bmp);
          Finally
            Bmp.Free;
          End;
        End
        Else
          FIMG.Assign(Jpg);

        FImage.Picture.Assign(Jpg);
      Finally
        Jpg.Free;
      End;
    End
    Else If (FileExt = '.bmp') And (fiBMP In FormatIMG) Then
    Begin
      Bmp := TBitmap.Create;
      Try
        Bmp.LoadFromFile(sImgFileName);

        If Not Assigned(IMG) Then
          FIMG := T.Create;

        FIMG.Assign(Bmp);
        FImage.Picture.Assign(Bmp);
      Finally
        Bmp.Free;
      End;
    End
    Else If (FileExt = '.png') And (fiPNG In FormatIMG) Then
    Begin
      Png := TPngImage.Create;
      Try
        Png.LoadFromFile(sImgFileName);

        If Not Assigned(IMG) Then
          FIMG := T.Create;

        // cannot assign png to jpg directly
        If FIMG.ClassNameIs('TJPEGImage') Then
        Begin
          Bmp := TBitmap.Create;
          Try
            Bmp.Assign(Png);
            FIMG.Assign(Bmp);
          Finally
            Bmp.Free;
          End;
        End
        Else
          FIMG.Assign(Png);

        FImage.Picture.Assign(Png);
      Finally
        Png.Free;
      End;
    End
    Else
      Raise Exception.Create(lng_FileExtIsBad);

    FFileName := ExtractFileName(sImgFileName);

    If Assigned(OnAfterLoadImg) Then
      OnAfterLoadImg(Self);
  Except
    FreeAndNil(FIMG);
    Raise;
  End;
End;

Procedure TImageDropDown<T>.SelectIMG;
Var
  sFileMask: String;
Begin
  sFileMask := '';
  If fiJPG In FormatIMG Then
    sFileMask := sFileMask + '*.jpg;*.jpeg;';
  If fiBMP In FormatIMG Then
    sFileMask := sFileMask + '*.bmp;';
  If fiPNG In FormatIMG Then
    sFileMask := sFileMask + '*.png';
  If (sFileMask <> '') And (sFileMask[Length(sFileMask) - 1] = ';') Then
    SetLength(sFileMask, -1);

  // if vista or +
  If Win32MajorVersion >= 6 Then
  Begin
    With TFileOpenDialog.Create(NIL) Do
      Try
        If fiJPG In FormatIMG Then
          DefaultExtension := 'jpg'
        Else If fiBMP In FormatIMG Then
          DefaultExtension := 'bmp'
        Else If fiPNG In FormatIMG Then
          DefaultExtension := 'png';

        With FileTypes.Add Do
        Begin
          DisplayName := lng_AllImages;
          FileMask := sFileMask;
        End;

        If fiJPG In FormatIMG Then
        Begin
          With FileTypes.Add Do
          Begin
            DisplayName := lng_JPGImages;
            FileMask := '*.jpg;*.jpeg';
          End;
        End;

        If fiBMP In FormatIMG Then
        Begin
          With FileTypes.Add Do
          Begin
            DisplayName := lng_BMPImages;
            FileMask := '*.bmp';
          End;
        End;

        If fiPNG In FormatIMG Then
        Begin
          With FileTypes.Add Do
          Begin
            DisplayName := lng_PNGImages;
            FileMask := '*.png';
          End;
        End;

        If Execute Then
          LoadIMG(FileName);
      Finally
        Free;
      End;
  End
  Else
  Begin
    With TOpenDialog.Create(NIL) Do
      Try
        sFileMask := lng_AllImages + '|' + sFileMask + '|';
        If fiJPG In FormatIMG Then
          sFileMask := sFileMask + lng_JPGImages + '|*.jpg;*.jpeg|';
        If fiBMP In FormatIMG Then
          sFileMask := sFileMask + lng_BMPImages + '|*.bmp|';;
        If fiPNG In FormatIMG Then
          sFileMask := sFileMask + lng_PNGImages + '|*.png';
        If (sFileMask <> '') And (sFileMask[Length(sFileMask) - 1] = '|') Then
          SetLength(sFileMask, -1);

        Filter := sFileMask;
        Options := [ofHideReadOnly, ofFileMustExist, ofEnableSizing];

        If Execute Then
          LoadIMG(FileName);
      Finally
        Free;
      End;
  End;
End;

Procedure TImageDropDown<T>.ImageWindowProc(Var Msg: TMessage);
Begin
  If Msg.Msg = WM_DROPFILES Then
    ImageDrop(TWMDROPFILES(Msg))
  Else
    originalImageWindowProc(Msg);
End;

Constructor TImageDropDown<T>.Create(AImage: TImage; APanel: TPanel);
Begin
  FormatIMG := [fiJPG, fiBMP, fiPNG];
  FImage := AImage;
  FPanel := APanel;
  FFileName := '';
  FOnBeforeLoadImg := NIL;
  FOnAfterLoadImg := NIL;

  originalImageWindowProc := APanel.WindowProc;
  APanel.WindowProc := ImageWindowProc;
  DragAcceptFiles(APanel.Handle, True);
End;

Destructor TImageDropDown<T>.Destroy;
Begin
  If Assigned(FPanel) Then
  Begin
    FPanel.WindowProc := originalImageWindowProc;
    DragAcceptFiles(FPanel.Handle, False);
  End;

  If Assigned(FIMG) Then
    FIMG.Free;

  Inherited;
End;

Procedure TImageDropDown<T>.ImageDrop(Var Msg: TWMDROPFILES);
Var
  numFiles: Longint;
  Buffer: Array [0 .. MAX_PATH] Of Char;
Begin
  numFiles := DragQueryFile(Msg.Drop, $FFFFFFFF, NIL, 0);
  If numFiles = 1 Then
  Begin
    DragQueryFile(Msg.Drop, 0, @Buffer, sizeof(Buffer));
    LoadIMG(Buffer);
  End
  Else
    Raise Exception.Create(lng_CannotLoadLotOfImg);
End;

End.

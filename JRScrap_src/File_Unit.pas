// This file is part of the JRScrap project.
// Licence : GPL v 3

// Website : https://github.com/fredele/JRScrap/

// Year : 2014

// Author : frederic klieber

unit File_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, ShellAPI;
// Get the File size
function FileSize(const aFilename: String): Int64;
function FileOrFolderDeleteRB(aFilename: string): boolean;
procedure RemoveEmptyFolders(const rootFolder: string);
function FileCount(Path: String): Integer;
procedure RemoveFolder(const Dir: String);
function GetAllDirFilesSortNum(folder: string): TStringList;
function GetFilesinFolder(Path: string): TStringList;
function compare(List: TStringList; Index1, Index2: Integer): Integer;
function RemoveAllFilesFromFolder(const folder, Prefix: String): boolean;
function LoadFileToStr(const FileName: TFileName): String;
function GetTempDirectory: String;
procedure StrToFile(const FileName, SourceString: string);
function IsFileInUse(FileName: TFileName): boolean;
function Get_FileSize(FileName: wideString): Int64;

implementation

function Get_FileSize(FileName: wideString): Int64;
var
  sr: TSearchRec;
begin
  if FindFirst(FileName, faAnyFile, sr) = 0 then
    result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) +
      Int64(sr.FindData.nFileSizeLow)
  else
    result := -1;

  FindClose(sr);
end;

function GetTempDirectory: String;
var
  tempFolder: array [0 .. MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @tempFolder);
  result := StrPas(tempFolder);
end;

function IsFileInUse(FileName: TFileName): boolean;
var
  HFileRes: HFILE;
begin
  result := False;
  if not FileExists(FileName) then
    Exit;
  HFileRes := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  result := (HFileRes = INVALID_HANDLE_VALUE);
  if not result then
    CloseHandle(HFileRes);
end;

procedure StrToFile(const FileName, SourceString: string);
var
  Lines: TStrings;
  Line: string;
begin
  if FileExists(FileName) then
    deleteFile(FileName);

  Lines := TStringList.Create;
  Lines.DefaultEncoding := TEncoding.UTF8;
  for Line in SourceString do
  begin
    Lines.Add(Line);
  end;
  Lines.SaveToFile(FileName);
end;

function LoadFileToStr(const FileName: TFileName): String;
var
  LStrings: TStringList;
begin
  LStrings := TStringList.Create;
  try
    LStrings.Loadfromfile(FileName);
    result := LStrings.text;
  finally
    FreeAndNil(LStrings);
  end;
end;

// Delete all files from this Folder
function RemoveAllFilesFromFolder(const folder, Prefix: String): boolean;
var
  FileOpStruct: TSHFileOpStruct;
begin
  result := False;
  if DirectoryExists(folder) then
  begin
    FillChar(FileOpStruct, SizeOf(FileOpStruct), 0);
    FileOpStruct.Wnd := 0;
    FileOpStruct.wFunc := FO_DELETE;
    FileOpStruct.pFrom := PChar(IncludeTrailingPathDelimiter(folder) + Prefix);
    FileOpStruct.fFlags := FOF_FILESONLY or FOF_SILENT or FOF_NOCONFIRMATION;
    SHFileOperation(FileOpStruct);
    result := True;
  end; // if
end; // RemoveFromFolder

function FileCount(Path: String): Integer;
var
  SearchRec: TSearchRec;
begin
  result := 0;
  Path := IncludeTrailingBackslash(ExtractFilePath(Path)) + '*.*';
  if FindFirst(Path, faAnyFile, SearchRec) = 0 then
    repeat
      if SearchRec.Attr <> faDirectory then
        Inc(result);
    until FindNext(SearchRec) <> 0;
end;

function FileSize(const aFilename: String): Int64;
var
  info: TWin32FileAttributeData;
begin
  result := -1;

  if NOT GetFileAttributesEx(PWideChar(aFilename), GetFileExInfoStandard, @info)
  then
    Exit;

  result := info.nFileSizeLow or (info.nFileSizeHigh shl 32);
end;

function FileOrFolderDeleteRB(aFilename: string): boolean;
var
  Struct: TSHFileOpStruct;
  pFromc: array [0 .. 255] of Char;
  Resultval: Integer;
begin
  if not FileExists(aFilename) then
  begin
    result := False;
    Exit;
  end
  else
  begin
    FillChar(pFromc, SizeOf(pFromc), 0);
    StrPcopy(pFromc, expandfilename(aFilename) + #0#0);
    Struct.Wnd := 0;
    Struct.wFunc := FO_DELETE;
    Struct.pFrom := pFromc;
    Struct.pTo := nil;
    Struct.fFlags := FOF_ALLOWUNDO or FOF_NOCONFIRMATION or FOF_SILENT;
    Struct.fAnyOperationsAborted := False;
    Struct.hNameMappings := nil;
    Resultval := SHFileOperation(Struct);
    result := (Resultval = 0);
  end;
end;

procedure RemoveEmptyFolders(const rootFolder: string);
var
  fd: TWin32FindData;
  h: THandle;
  rf: string;
begin
  rf := IncludeTrailingBackslash(rootFolder);
  h := FindFirstFile(PChar(rf + '*.*'), fd);
  if h <> INVALID_HANDLE_VALUE then

    with fd do
      repeat
        if (dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY > 0) and
          (Pos(cFileName, '.;..') = 0) then
        begin
          if not RemoveDir(rf + cFileName) then
            RemoveEmptyFolders(rf + cFileName);
        end;
      until not FindNextFile(h, fd);

end;

procedure RemoveFolder(const Dir: String);
var
  sDir: String;
  Rec: TSearchRec;
begin
  sDir := IncludeTrailingPathDelimiter(Dir);
  if FindFirst(sDir + '*.*', faAnyFile, Rec) = 0 then
    try
      repeat
        if (Rec.Attr and faDirectory) = faDirectory then
        begin
          if (Rec.Name <> '.') and (Rec.Name <> '..') then
            RemoveFolder(sDir + Rec.Name);
        end
        else
        begin
          deleteFile(sDir + Rec.Name);
        end;
      until FindNext(Rec) <> 0;
    finally
      FindClose(Rec);
    end;
  RemoveDir(sDir);
end;

function GetAllDirFilesSortNum(folder: string): TStringList;
var
  sr: TSearchRec;
  DirList: TStringList;
begin
  DirList := TStringList.Create;

  if FindFirst('*.*', faArchive, sr) = 0 then
  begin
    repeat
      DirList.Add(sr.Name); // Fill the list
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  DirList.CustomSort(compare);
  result := DirList;

end;

// List all Files in a Folder
function GetFilesinFolder(Path: string): TStringList;
var
  sr: TSearchRec;
  Dest: TStringList;
begin
  Dest := TStringList.Create;
  if FindFirst(Path + '*.*', faAnyFile, sr) = 0 then
    repeat
      Dest.Add(sr.Name);
    until FindNext(sr) <> 0;
  FindClose(sr);
  result := Dest;
end;

function compare(List: TStringList; Index1, Index2: Integer): Integer;
var
  n1, n2: Integer;
begin
  n1 := StrToInt(Copy(List[Index1], 3, Length(List[Index1]) - 6));
  n2 := StrToInt(Copy(List[Index2], 3, Length(List[Index2]) - 6));
  result := n1 - n2;
end;

end.

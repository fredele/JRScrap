// This file is part of th JRScrap project.
// Licence : GPL v 3
// Website : https://github.com/fredele/JRScrap/
// Year : 2014
// Author : frederic klieber

unit ThreadManager_Unit;

interface

uses
  Types_Unit, Threadsearch_Unit, debug_Unit, System.Classes,
  Generic_Search_Unit;

type

  TThreadManager = class(TComponent)

  public
  var
    FProcedure: TProcedure;
    FProcedureobj: TProcedureobj;
    Fterminated: boolean;
    Fthreadnumbers: integer;
    FActualthreadCompleted: integer;
    ThreadsearchArray: array of TThreadsearch;
    Threadsearch_ImageArray: array of TThreadsearch_Image;
    procedure resume;

    procedure Addthread(coding: Tcod; query: string; Proc: TProcedureStr); overload;
    procedure Addthread(coding: Tcod; query: string; Proc: TProcedureStrobj); overload;
    procedure Addthread(query: string; ProcImg: TProcedureImg); overload;

    procedure IncFActualthreadCompleted;
    constructor Create(AOwner: TGeneric_Search; Proc: TProcedureobj); overload;
    constructor Create(AOwner: TGeneric_Search; Proc: TProcedure); overload;
    property ActualthreadCompleted: integer read FActualthreadCompleted;
    property terminated: boolean read Fterminated write Fterminated;
  end;

implementation

procedure TThreadManager.Addthread(coding: Tcod; query: string; Proc: TProcedureStr);
var
  th: TThreadsearch;
begin
  th := TThreadsearch.Create(self, coding, query, Proc);
  Setlength(ThreadsearchArray, length(ThreadsearchArray) + 1);
  ThreadsearchArray[length(ThreadsearchArray) - 1] := th;
end;

procedure TThreadManager.Addthread(coding: Tcod; query: string; Proc: TProcedureStrobj);
var
  th: TThreadsearch;
begin
  th := TThreadsearch.Create(self, coding, query, Proc);
  Setlength(ThreadsearchArray, length(ThreadsearchArray) + 1);
  ThreadsearchArray[length(ThreadsearchArray) - 1] := th;
end;


procedure TThreadManager.Addthread(query: string; ProcImg: TProcedureImg);

var
  th: TThreadsearch_Image;
begin
  th := TThreadsearch_Image.Create(self, query, ProcImg);
  Setlength(Threadsearch_ImageArray, length(Threadsearch_ImageArray) + 1);
  Threadsearch_ImageArray[length(Threadsearch_ImageArray) - 1] := th;
end;

constructor TThreadManager.Create(AOwner: TGeneric_Search; Proc: TProcedureobj);
begin
  FProcedureobj := Proc;
  FActualthreadCompleted := 0;
  Fterminated := False;
end;

constructor TThreadManager.Create(AOwner: TGeneric_Search; Proc: TProcedure);
begin
  FProcedure := Proc;
  FActualthreadCompleted := 0;
  Fterminated := False;
end;

procedure TThreadManager.IncFActualthreadCompleted;
var
  i: integer;
begin
  inc(FActualthreadCompleted);
  if FActualthreadCompleted = length(ThreadsearchArray) +
    length(Threadsearch_ImageArray) then
  begin

    {
      for i := 0 to  length(Threadsearch_ImageArray) -1 do
      begin
      debug(i);

      if assigned( Threadsearch_ImageArray[i]) then
      Threadsearch_ImageArray[i].Terminate ;
      end;

      for i := 0 to  length(ThreadsearchArray) -1 do
      begin
      ThreadsearchArray[i].Terminate ;
      end;

    }
    debug('fait !') ;
    if assigned(FProcedure) then
    begin
      FProcedure;
    end;

    if assigned(FProcedureobj) then
    begin
      FProcedureobj;
    end;

    Fterminated := true;
  end;
end;

procedure TThreadManager.resume;
var
  i: integer;
begin

  for i := 0 to length(Threadsearch_ImageArray) - 1 do
  begin
    debug(i);
    if assigned(Threadsearch_ImageArray[i]) then
      Threadsearch_ImageArray[i].resume;
  end;

  for i := 0 to length(ThreadsearchArray) - 1 do
  begin
    ThreadsearchArray[i].resume;
  end;

end;

end.

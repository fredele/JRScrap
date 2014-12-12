unit Math_Unit;

interface

uses
  System.SysUtils, Math, debug_Unit;

function Int64ToBinStr(val: Int64): string;
function Complement(val: string): string;
function BinToHex(val: string): string;
function Int64ToHex(val: Int64): string;

implementation

function Int64ToBinStr(val: Int64): string;
var
  q: Int64;
  r, i: integer;
  s: string;
begin
  q := val;
  while q > 0 do
  begin
    r := q mod 2;
    s := intTostr(r) + s;
    q := q div 2;
  end;

  // Add '0' at the beginning to have complete  sets of 4 bits .
  for i := 0 to 4 * (length(s) div 4 + 1) - length(s) - 1 do
  begin
    s := '0' + s;
  end;
  result := s;
end;

function Complement(val: string): string;
var
  i, cpt, nbr: integer;
  res: string;
begin
  res := '';
  debug(length(val));
  for i := 0 to length(val) do
  begin
    if val[i] = '0' then
      res := res + '1';
    if val[i] = '1' then
      res := res + '0';
  end;
  debug(res[length(res)]);
  res[length(res)] := val[length(val)];

  if val[length(val)] = '0' then
  begin
    if res[length(res) - 1] = '0' then
    begin
      res[length(res) - 1] := '1';
    end
    else
    begin
      res[length(res) - 1] := '0';
    end;
  end;

  for i := 0 to 63 - length(res) do
  begin
    res := '1' + res;
  end;
  debug(length(res));
  result := res;
end;

function BinToHex(val: string): string;
var
  cpt: integer;
const
  BinArray: array [0 .. 15, 0 .. 1] of string = (('0000', '0'), ('0001', '1'),
    ('0010', '2'), ('0011', '3'), ('0100', '4'), ('0101', '5'), ('0110', '6'),
    ('0111', '7'), ('1000', '8'), ('1001', '9'), ('1010', 'A'), ('1011', 'B'),
    ('1100', 'C'), ('1101', 'D'), ('1110', 'E'), ('1111', 'F'));
var
  Error: Boolean;
  i, j: integer;
  BinPart, id, res: string;
begin

  cpt := length(val) mod 4;
  for i := 0 to cpt - 1 do
  begin
    val := '0' + val;
  end;

  res := '';
  result := '';
  cpt := length(val);
  cpt := (cpt div 4);
  for i := 0 to cpt - 1 do
  begin
    id := '';
    id := val[i * 4 + 1] + val[i * 4 + 2] + val[i * 4 + 3] + val[i * 4 + 4];

    for j := 0 to 15 do
    begin
      if id = BinArray[j, 0] then
        res := res + BinArray[j, 1];
    end;

  end;

  i := length(res) - 1;
  while res[i] = '0' do
  begin
    res[i] := ' ';
    i := i - 1;
  end;
  res := trim(res);

  result := res;

end;

function Int64ToHex(val: Int64): string;
var
  res, resinv: string;
begin
  if val < 0 then
  begin
    val := abs(val);
    res := Int64ToBinStr(val);
    resinv := Complement(res);
    res := BinToHex(resinv);
  end
  else
  begin

    res := Int64ToBinStr(val);
    res := BinToHex(res);
  end;
  result := res;
end;

end.

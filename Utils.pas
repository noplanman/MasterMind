unit Utils;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: Utils.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit Utils enthält variablen die das Programm braucht
  =======================================================================*)

interface

uses GlobalDefinitions, Classes, Graphics;

  function GetResult(Muster: TMuster): TResultat;
  procedure SetVorgabe(FarbWiederholung: Boolean);

var
  Vorgabe: TMuster;
  platz : integer;

implementation
uses reg;

procedure Init;
begin
  //Vorgabe Setzen
  Vorgabe[0] := clBlue;
  Vorgabe[1] := clRed;
  Vorgabe[2] := clYellow;
  Vorgabe[3] := clGray;
  Vorgabe[4] := clLime;
  Vorgabe[5] := clFuchsia;
end;

function GetResult(Muster: TMuster): TResultat;
var
  PosM : integer; //Positionszeiger im Array Muster
  PosV : integer; //Positionszeiger im Array Vorgabe
  kopie : TMuster;
begin
  Kopie := Vorgabe;
  Result.Platz := 0;
  Result.Farbe := 0;
  //Richtige Farben am RICHTIGEN Platz herausfinden
  for PosM := 0 to AnzFarben - 1 do
  begin
    if Muster[PosM] = Kopie[PosM] then
    begin
      Muster[PosM] := clWhite;
      Kopie[PosM] := clWhite;
      inc(Result.Platz);
    end;
  end;
  PosV := 0;
  //Richtige Farben am FALSCHEN Platz herausfinden
  for PosM := 0 to AnzFarben -1 do
  begin
    if Muster[PosM] <> clWhite then
    begin
      while (Muster[PosM] <> Kopie[PosV]) and (PosV < AnzFarben)
      do Inc(PosV);
      if Muster[PosM] = Kopie[PosV] then
      begin
        Kopie[PosV] := clWhite;
        Inc(Result.Farbe);
      end;
    PosV := 0;
    end
  end;
  platz := result.Platz;
end;

procedure SetVorgabe(FarbWiederholung: Boolean);
  procedure SwapFarben(var f1,f2 : TColor);
  var
    temp : TColor;
  begin
    temp := f1;
    f1 := f2;
    f2 := temp;
  end;
var
  i : integer;
  temp : TMuster;
begin
  Init;
  if FarbWiederholung then
  begin
    //Farbwiederholung erlaubt
    for i := 0 to AnzFarben - 1 do temp[i] := Vorgabe[random(AnzFarben)];
    Vorgabe := temp;
  end
  else
  begin
    //Farbwiederholung nicht erlaubt
    for i := 0 to AnzFarben - 1 do SwapFarben(Vorgabe[i], Vorgabe[random(AnzFarben)]);
  end;
end;

initialization
  Randomize;
  reg.readoptions(FarbWiederholung,AnzFarben);
  Init;

end.

unit Reg;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: Reg.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit Reg beinhaltet das laden und speichern der Optionen in der
  Registry
  =======================================================================*)

interface

procedure saveoptions(Farbwiederholung : Boolean; AnzFarben : integer);
procedure readoptions(var Farbwiederholung : Boolean; var AnzFarben : integer);
procedure ReadScores;
procedure WriteScores;
procedure SaveScores(NewName : string; NewScore : integer);

implementation
uses Registry, GlobalDefinitions, Classes, HighScores, SysUtils, StdCtrls, ComCtrls;

var
  lblnames : Array[0..9] of ^TLabel;
  lblscores : Array[0..9] of ^TLabel;
  pHS : TpHS;
  HSList : TList;

procedure Init;
begin
  //addressen der name lbls speichern
  lblnames[0] := @(Frm_HS.lblname1);
  lblnames[1] := @(Frm_HS.lblname2);
  lblnames[2] := @(Frm_HS.lblname3);
  lblnames[3] := @(Frm_HS.lblname4);
  lblnames[4] := @(Frm_HS.lblname5);
  lblnames[5] := @(Frm_HS.lblname6);
  lblnames[6] := @(Frm_HS.lblname7);
  lblnames[7] := @(Frm_HS.lblname8);
  lblnames[8] := @(Frm_HS.lblname9);
  lblnames[9] := @(Frm_HS.lblname10);

  //addressen der score lbls speichern
  lblscores[0] := @(Frm_HS.lblscore1);
  lblscores[1] := @(Frm_HS.lblscore2);
  lblscores[2] := @(Frm_HS.lblscore3);
  lblscores[3] := @(Frm_HS.lblscore4);
  lblscores[4] := @(Frm_HS.lblscore5);
  lblscores[5] := @(Frm_HS.lblscore6);
  lblscores[6] := @(Frm_HS.lblscore7);
  lblscores[7] := @(Frm_HS.lblscore8);
  lblscores[8] := @(Frm_HS.lblscore9);
  lblscores[9] := @(Frm_HS.lblscore10);
end;

procedure FirstStart;
var
  regist : TRegistry;
begin
  regist := TRegistry.Create;
  if regist.KeyExists('Software\EPS\MasterMind\HighScores') then
  else
  begin
    regist.OpenKey('Software\EPS\MasterMind\HighScores', true);

    //Erste Werte Schreiben
    //Die ersten Namen für die HighScore Liste
    regist.WriteString('1 name', 'Fredi');
    regist.WriteString('2 name', 'Lukas');
    regist.WriteString('3 name', 'Beni');
    regist.WriteString('4 name', 'Dodi');
    regist.WriteString('5 name', 'Thomas');
    regist.WriteString('6 name', 'Dani');
    regist.WriteString('7 name', 'Beat');
    regist.WriteString('8 name', 'Peter');
    regist.WriteString('9 name', 'Georg');
    regist.WriteString('10 name', 'Jürg');

    //Die ersten Zahlen für die HighScore Liste
    regist.WriteInteger('1 score', 10);
    regist.WriteInteger('2 score', 20);
    regist.WriteInteger('3 score', 30);
    regist.WriteInteger('4 score', 40);
    regist.WriteInteger('5 score', 50);
    regist.WriteInteger('6 score', 60);
    regist.WriteInteger('7 score', 70);
    regist.WriteInteger('8 score', 80);
    regist.WriteInteger('9 score', 90);
    regist.WriteInteger('10 score', 100);
  end;

  regist.Free;
end;

procedure saveoptions(Farbwiederholung : Boolean; AnzFarben : integer);
var
  regist : TRegistry;
begin
  //Registry einstellungen zum speichern der Optionen
  regist := TRegistry.Create;
  regist.OpenKey('Software\EPS\MasterMind', true);
  regist.WriteBool('fw', FarbWiederholung);
  regist.WriteInteger('af', AnzFarben);
  regist.Free;
end;

procedure readoptions(var Farbwiederholung : Boolean; var AnzFarben : integer);
var
  regist : TRegistry;
begin
  //Registry einstellungen zum laden der Optionen
  regist := TRegistry.Create;
  if regist.KeyExists('Software\EPS\MasterMind') then
  begin
    regist.OpenKey('Software\EPS\MasterMind', true);
    Farbwiederholung := regist.ReadBool('fw');
    AnzFarben := regist.ReadInteger('af');
  end
  else begin
    FarbWiederholung := cFarbWiederholung;
    AnzFarben := cAnzFarben;
    SaveOptions(FarbWiederholung, AnzFarben);
  end;
  FirstStart;
  regist.Free;
end;

procedure ReadScores;
var
  regist : TRegistry;
  i : integer;
begin
  HSList := TList.Create;
  HSList.Clear;
  regist := TRegistry.Create;
  regist.OpenKey('Software\EPS\MasterMind\HighScores', true);
  for i := 1 to 10 do
  begin
    //Speicher besetzen
    New(pHS);
    //Werte aus der Registry in die HighScoreList
    pHS^.Name := regist.ReadString(inttostr(i) + ' name');
    pHS^.Score := regist.ReadInteger(inttostr(i) + ' score');
    //Eintrag der Liste hinzufügen
    HSList.Add(pHS);
  end;
  regist.Free;
end;

procedure WriteScores;
var
  i : integer;
begin
  Init;
  for i := 0 to HSList.Count - 1 do
  begin
    //Werte aus der HighScoreList lesen und in die Labels schreiben
    pHS := HSList.Items[i];
    lblnames[i]^.Caption := pHS^.Name;
    lblscores[i]^.Caption := inttostr(pHS^.Score);
  end;
end;

procedure SortScores;
  procedure SwapScores(itemone,itemtwo : TpHS);
  var
    tempName : String;
    tempScore : Integer;
  begin
    //Zwei Zeilen in der HighScoreList vertauschen
    tempName := itemone^.Name;
    itemone^.Name := itemtwo^.Name;
    itemtwo^.Name := tempName;
    tempScore := itemone^.Score;
    itemone^.Score := itemtwo^.Score;
    itemtwo^.Score := tempScore;
  end;
var
  i : integer;
begin
  with HSList do
  begin
    i := Count-1;
    //Falls der obere Wert kleiner ist als der Untere, wird vertauscht
    while (TpHS(Items[i])^.Score < TpHS(Items[i-1])^.Score)
    and   (i > 0) do
    begin
      SwapScores(Items[i], Items[i-1]);
      dec(i);
    end;
  end;
end;

procedure SaveScores(NewName : string; NewScore : integer);
var
  regist : TRegistry;
  i : integer;
begin
  //Werte aus der Registry, in die HighScoreList lesen
  ReadScores;
  //HighScoreList mit einem Wert erweitern
  New(pHS);
  pHS^.Name := NewName;
  pHS^.Score := NewScore;
  HSList.Add(pHS);
  SortScores;
  //Nach dem sortieren die letzte Zeile löschen
  HSList.Delete(10);
  regist := TRegistry.Create;
  regist.OpenKey('Software\EPS\MasterMind\HighScores', true);
  for i := 0 to 9 do
  begin
    //HighScoreList in die Registry speichern
    pHS := HSList.Items[i];
    regist.WriteString(inttostr(i+1) + ' name', pHS^.Name);
    regist.WriteInteger(inttostr(i+1) + ' score', pHS^.Score);
  end;
  WriteScores;
  regist.Free;
end;

end.

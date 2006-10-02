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
  Die Unit Reg beinhaltet das laden und speichern der Optionen in der Registry
  =======================================================================*)

interface

procedure saveoptions(Farbwiederholung : Boolean; AnzFarben : integer);
procedure readoptions(var Farbwiederholung : Boolean; var AnzFarben : integer);

implementation
uses registry, GlobalDefinitions;

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
  end;
  regist.Free;
end;


end.
 
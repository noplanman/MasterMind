unit GlobalDefinitions;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: GlobalDefinitions.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit GlobalDefinitions enthält verschiedene Typen der Anwendung
  =======================================================================*)

interface

uses Graphics;

const
  cFarbWiederholung = true;
  cAnzFarben = 4;

type
  TMuster = Array[0..5] of TColor;
  TResultat = Record
              Platz: Word;
              Farbe: Word;
              end;
  TpEintrag = ^TEintrag;
  TEintrag =  Record
              Muster: TMuster;
              Resultat: TResultat;
              end;

var
  //Variablen AnzFarben und FarbWiederholung
  AnzFarben : integer;
  FarbWiederholung : boolean;
implementation

end.

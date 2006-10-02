unit HighScores;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: HighScores.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit HighScores zeigt die HighScores an
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFrm_HS = class(TForm)
    lblname1: TLabel;
    lblname2: TLabel;
    lblname3: TLabel;
    lblname4: TLabel;
    lblname5: TLabel;
    lblname6: TLabel;
    lblname7: TLabel;
    lblname8: TLabel;
    lblname9: TLabel;
    lblname10: TLabel;
    lblscore1: TLabel;
    lblscore2: TLabel;
    lblscore3: TLabel;
    lblscore4: TLabel;
    lblscore5: TLabel;
    lblscore6: TLabel;
    lblscore7: TLabel;
    lblscore8: TLabel;
    lblscore9: TLabel;
    lblscore10: TLabel;
    lblhighscores: TLabel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_HS: TFrm_HS;

implementation

{$R *.dfm}

end.

unit HighScoreNameEntry;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: HighScoreNameEntry.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit HighScoreNameEntry dient zur eingabe des Namens beim Gewinnen
  des Spiels
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrm_HSNE = class(TForm)
    btnok: TButton;
    edithsne: TEdit;
    procedure edithsneChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_HSNE: TFrm_HSNE;

implementation

{$R *.dfm}

procedure TFrm_HSNE.edithsneChange(Sender: TObject);
begin
  //Der Name für die HighScore darf nicht leer sein
  if edithsne.Text = ''
  then btnok.Enabled := false
  else btnok.Enabled := true;
end;

end.

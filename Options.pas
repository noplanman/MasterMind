unit Options;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: Options.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit Options setzt und speichert die Einstellungen
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  Tfrmoptions = class(TForm)
    rbcolors: TRadioGroup;
    cbfw: TCheckBox;
    btnok: TButton;
    btncancel: TButton;
    epschribel: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetParams(f : integer; w : boolean);
    procedure GetParams(var f : integer; var w : boolean);
    function ParamsChanged(f : integer; w : boolean): boolean;
  end;

var
  frmoptions: Tfrmoptions;

implementation

uses GlobalDefinitions;

{$R *.dfm}
function Tfrmoptions.ParamsChanged(f : integer; w : boolean): boolean;
begin
  result := (f <> rbcolors.ItemIndex + 4) or (w <> cbfw.Checked);
end;

procedure Tfrmoptions.SetParams(f : integer; w : boolean);
begin
  //AnzFarben und FarbWiederholung setzen
  rbcolors.ItemIndex := f - 4;
  cbfw.Checked := w;
end;

procedure Tfrmoptions.GetParams(var f : integer; var w : boolean);
begin
  //AnzFarben und FarbWiederholung laden
  f := rbcolors.ItemIndex + 4;
  w := cbfw.Checked;
end;

end.

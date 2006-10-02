unit Success;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: Success.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit Success ist das Form das angezeigt wird wenn man gewinnt
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  Tfrmsuccess = class(TForm)
    Label1: TLabel;
    btnclose: TButton;
    Image1: TImage;
    epschribel: TImage;
    procedure btncloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmsuccess: Tfrmsuccess;

implementation

{$R *.dfm}

procedure Tfrmsuccess.btncloseClick(Sender: TObject);
begin
  close;
end;

end.

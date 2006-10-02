unit Solution;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: Solution.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit Solution ist das Form das angezeigt wird wenn man aufgibt
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  Tfrmsolution = class(TForm)
    Label1: TLabel;
    l1: TShape;
    l2: TShape;
    l3: TShape;
    l4: TShape;
    l5: TShape;
    l6: TShape;
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
  frmsolution: Tfrmsolution;

implementation

{$R *.dfm}

procedure Tfrmsolution.btncloseClick(Sender: TObject);
begin
  close;
end;

end.

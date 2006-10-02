unit main;
(*=========================================================================
               EPS AG
  =========================================================================
  Programm        : MasterMind
  Quelldatei      : $Workfile: main.pas$
  Prog. Sprache   : Delphi Pascal
  Plattform       : PC mit Pentium
  Betriebsystem   : Windows XP
  Aktueller Stand : $JustDate: 17.09.2004$
  =========================================================================
  Die Unit main ist das Haupt Unit des Programms
  =======================================================================*)

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ColorGrd, ExtCtrls, Grids, Buttons, ComCtrls, StdCtrls,
  Utils, GlobalDefinitions, jpeg;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    NeuesSpiel1: TMenuItem;
    Beenden1: TMenuItem;
    Optionen1: TMenuItem;
    StatusBar1: TStatusBar;
    sbnewgame: TSpeedButton;
    sbresign: TSpeedButton;
    sbquit: TSpeedButton;
    sb1: TSpeedButton;
    sb2: TSpeedButton;
    sb3: TSpeedButton;
    sb4: TSpeedButton;
    sb5: TSpeedButton;
    sb6: TSpeedButton;
    pmcolors: TPopupMenu;
    Blau1: TMenuItem;
    Rot1: TMenuItem;
    Gelb1: TMenuItem;
    Grau1: TMenuItem;
    Grn1: TMenuItem;
    Pink1: TMenuItem;
    Panel1: TPanel;
    history: TImage;
    sbtry: TSpeedButton;
    None: TMenuItem;
    lbltries: TLabel;
    Schwierigkeitsgrad: TMenuItem;
    answer: TMenuItem;
    Panel2: TPanel;
    lblhundred: TLabel;
    lblten: TLabel;
    lblone: TLabel;
    Image1: TImage;
    HighScores1: TMenuItem;
    Label1: TLabel;
    procedure ButtonClick(Sender: TObject);
    procedure sbtryClick(Sender: TObject);
    procedure FarbeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sbnewgameClick(Sender: TObject);
    procedure NeuesSpiel1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure sbquitClick(Sender: TObject);
    procedure NoneClick(Sender: TObject);
    procedure sbresignClick(Sender: TObject);
    procedure SchwierigkeitsgradClick(Sender: TObject);
    procedure answerClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure HighScores1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Eingabe : TMuster;
  pEintrag : TpEintrag;
  HistoryList : TList;
  versuche : integer;

implementation
uses Solution, Success, Options, Reg, HighScoreNameEntry, HighScores;

{$R *.dfm}
const
  clrs : Array[0..5] of TColor =
  (clBlue, clRed, clYellow, clGray, clLime, clFuchsia);
var
  btns : Array[0..5] of ^TSpeedButton;
  index : integer;

procedure Init;
var
  i : integer;
begin
  // Adressen der SpeedButtons speichern
  btns[0] := @(Form1.sb1);
  btns[1] := @(Form1.sb2);
  btns[2] := @(Form1.sb3);
  btns[3] := @(Form1.sb4);
  btns[4] := @(Form1.sb5);
  btns[5] := @(Form1.sb6);
  //Eingabearray initialisieren
  for i := 0 to 5 do
  eingabe[i] := clWhite;
end;

procedure Resign;
begin
  //Anzahl Punkte auf dem frmsolution einstellen
  frmsolution.l4.Visible := AnzFarben > 3;
  if AnzFarben > 3 then frmsolution.Width := (8 * frmsolution.l1.Width) + 5;
  frmsolution.l5.Visible := AnzFarben > 4;
  if AnzFarben > 4 then frmsolution.Width := (9 * frmsolution.l1.Width) + 5;
  frmsolution.l6.Visible := AnzFarben > 5;
  if AnzFarben > 5 then frmsolution.Width := (10 * frmsolution.l1.Width) + 5;
  frmsolution.epschribel.Left := (AnzFarben + 2) * frmsolution.l1.Width;
  frmsolution.l1.Brush.Color := vorgabe[0];
  frmsolution.l2.Brush.Color := vorgabe[1];
  frmsolution.l3.Brush.Color := vorgabe[2];
  frmsolution.l4.Brush.Color := vorgabe[3];
  frmsolution.l5.Brush.Color := vorgabe[4];
  frmsolution.l6.Brush.Color := vorgabe[5];
end;

procedure Dummy;
begin
  //Setzt die Breite des Canvas auf (7 * Breite eines Speedbuttons)
  form1.history.Width := form1.sb1.Width * 7;
  //History Rahmen zeichnen
  form1.History.Canvas.Pen.Color := clBlack;
  form1.History.Canvas.Brush.Color := clWhite;
  form1.History.Canvas.Rectangle(form1.history.Left,0,
                                 form1.sb1.Left - 2,form1.history.Height);
  form1.History.Canvas.Rectangle(form1.sb1.Left,0,
                                 form1.history.Width,form1.history.Height);
end;

procedure RedrawGame(AnzFarben : integer);
begin
  //Farben dem Schwierigkeitsgrad anpassen
  form1.Pink1.Visible := AnzFarben > 5;
  form1.Grn1.Visible := AnzFarben > 4;
  //Buttons dem Schwierigkeitsgrad anpassen
  form1.sb5.Visible := AnzFarben > 4;
  form1.sb6.Visible := AnzFarben > 5;
  //History Breite einstellen
  form1.history.Width := form1.sb1.Width * (AnzFarben + 1);
  //History Rahmen zeichnen
  form1.History.Canvas.Pen.Color := clBlack;
  form1.History.Canvas.Brush.Color := clWhite;
  form1.History.Canvas.Rectangle(form1.history.Left,0,
                                 form1.sb1.Left - 2,form1.history.Height);
  form1.History.Canvas.Rectangle(form1.sb1.Left,0,
                                 form1.history.Width,form1.history.Height);
end;

procedure NewGame;
begin
  //Leert die HistoryList
  HistoryList.Clear;
  redrawgame(AnzFarben);
  form1.sbtry.Enabled := true;
  form1.none.Click;
  form1.lblone.Caption := '0';
  form1.lblten.Caption := '0';
  form1.lblhundred.Caption := '0';
  versuche := 0;
  //Setzt alle Bilder der Buttons zurück
  form1.sb1.Glyph := form1.none.Bitmap;
  form1.sb2.Glyph := form1.none.Bitmap;
  form1.sb3.Glyph := form1.none.Bitmap;
  form1.sb4.Glyph := form1.none.Bitmap;
  form1.sb5.Glyph := form1.none.Bitmap;
  form1.sb6.Glyph := form1.none.Bitmap;
  SetVorgabe(FarbWiederholung);
end;

procedure zaehler;
var
  one : integer;
  ten : integer;
  hundred : integer;
begin
  //Der 'versuche' Zähler
  one := versuche mod 10;
  ten := (versuche div 10) mod 10;
  hundred := (versuche div 100) mod 10;
  form1.lblone.Caption := inttostr(one);
  form1.lblten.Caption := inttostr(ten);
  form1.lblhundred.Caption := inttostr(hundred);
end;

procedure NewGameClick;
begin
   {Falls kein Spiel angefangen oder das Spiel bereits beendet ist,
    Startet es das Spiel ohne Abfage neu}
  if (not form1.sbtry.Enabled) or (versuche = 0) or
     (application.MessageBox
     ('Spiel verwerfen und neu starten?', 'Neu Starten?', 36) = IDYES)
  then NewGame;
end;

procedure UpdateStatusBar;
begin
  //FarbWiederholung in den StatusBar schreiben
  if FarbWiederholung
  then form1.StatusBar1.Panels[1].Text := 'FW: Ja'
  else form1.StatusBar1.Panels[1].Text := 'FW: Nein';
  //Anzahl Farben in den StatusBar schreiben
  form1.StatusBar1.Panels[2].Text := 'AF: ' + inttostr(AnzFarben);
end;

procedure DispEintrag(pEintrag: TpEintrag; z: integer);
var
  sbachtel : integer;
  sb : integer;
  i : integer;
  y : integer;
begin
  //Ausgabe der farbigen Punkte auf dem Bildschirm
  sbachtel := form1.sb1.Width div 8;
  sb := form1.sb1.Width;
  y := form1.history.Height div 15;
  for i := 0 to AnzFarben - 1 do
  begin
    form1.history.Canvas.Brush.Color := pEintrag^.Muster[i];
    form1.history.Canvas.Ellipse(sb * (i + 1) + (2 * sbachtel),
                                 (z - 1) * y - sbachtel,
                                 sb * (i + 1) + (6 * sbachtel),
                                 z * y - sbachtel);
  end;
  form1.history.Canvas.Brush.Color := clWhite;
  form1.history.Canvas.Font.Color := clGreen;
  form1.history.Canvas.TextOut(sbachtel * 2,(z - 1) * y,
                               inttostr(pEintrag^.Resultat.Platz));
  form1.history.Canvas.Font.Color := clRed;
  form1.history.Canvas.TextOut(sbachtel * 5,(z - 1) * y,
                               inttostr(pEintrag^.Resultat.Farbe));
end;

procedure DispListe;
var
  Zeile : integer;
  i : integer;
  x : integer;
begin
  x := 0;
  Zeile := 15;
  if x > 15 then x := HistoryList.Count - 15;
  for i := HistoryList.Count - 1 downto x do
  begin
    DispEintrag(HistoryList.Items[i],Zeile);
    Dec(Zeile);
  end
end;

procedure TForm1.ButtonClick(Sender: TObject);
  function SetParams(i : integer; s : TSpeedButton):integer;
  begin
    index := i;
    Result := s.Left;
  end;
var
  links : integer;
begin
  //Position des PopupMenüs einstellen
  if Sender = sb1 then links := SetParams(0, sb1)
  else if Sender = sb2 then links := SetParams(1, sb2)
  else if Sender = sb3 then links := SetParams(2, sb3)
  else if Sender = sb4 then links := SetParams(3, sb4)
  else if Sender = sb5 then links := SetParams(4, sb5)
  else if Sender = sb6 then links := SetParams(5, sb6);
  pmcolors.Popup(form1.Left + links + 4 ,
                 form1.Top + sb1.Top + sb1.Height + 50);
end;

procedure TForm1.sbtryClick(Sender: TObject);
begin
  //Speicher besetzen
  New(pEintrag);
  pEintrag^.Muster := Eingabe;
  pEintrag^.Resultat := GetResult(Eingabe);
  //Eintrag der Liste hinzufügen
  HistoryList.Add(pEintrag);
  DispListe;
  //Zähler der Versuche
  inc(versuche);
  zaehler;
  //Wenn alle am richtigen Platz sind, frmsuccess aufrufen
  if Platz = anzfarben then
  begin
    frmsuccess.Label1.Caption := 'Gewonnen!' + #13 +
                                 'Mit ' + inttostr(versuche) + ' Versuche';
    frmsuccess.ShowModal;
    sbtry.Enabled := false;
    if Frm_HSNE.ShowModal = mrOK
    then
    begin
      //Die Highscore wird gespeichert
      SaveScores(Frm_HSNE.edithsne.Text, versuche);
      Frm_HS.ShowModal;
    end;
  end;
end;

procedure TForm1.FarbeClick(Sender: TObject);
  procedure SetFarbe(c: TColor; b: TBitmap);
  begin
    //SpeedButtons und Bitmaps deklarieren
    btns[index]^.Glyph := b;
    Eingabe[index] := c;
  end;
begin
  //Farben den SpeedButtons übergeben
  if Sender = Blau1 then SetFarbe(clBlue, Blau1.Bitmap)
  else if Sender = Rot1 then SetFarbe(clRed, Rot1.Bitmap)
  else if Sender = Gelb1 then SetFarbe(clYellow, Gelb1.Bitmap)
  else if Sender = Grau1 then SetFarbe(clGray, Grau1.Bitmap)
  else if Sender = Grn1 then SetFarbe(clLime, Grn1.Bitmap)
  else if Sender = Pink1 then SetFarbe(clFuchsia, Pink1.Bitmap);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Init;
  { Stellt die Breite des Canvas history auf die maximale Breite die es benötigt
    Komischer Effekt in Delphi wenn man es nicht zuerst setzt!}
  Dummy;
  //Liste erstellen, StatusBar aktualisieren und das Spiel neu starten
  HistoryList := TList.Create;
  UpdateStatusBar;
  NewGame;
end;

procedure TForm1.sbnewgameClick(Sender: TObject);
begin
  NewGameClick;
end;

procedure TForm1.NeuesSpiel1Click(Sender: TObject);
begin
  NewGameClick;
end;

procedure TForm1.Beenden1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.sbquitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.NoneClick(Sender: TObject);
var
  i : integer;
begin
  //Setzt die Farbe aller Eingabe Felder auf Silber
  for i := 0 to AnzFarben-1 do
  Eingabe[i] := clWhite;
end;

procedure TForm1.sbresignClick(Sender: TObject);
begin
  //Abfrage ob man wirklich aufgeben will
  if sbtry.Enabled then
  begin
    if application.MessageBox
       ('Lösung anzeigen und Spiel neu starten?', 'Aufgeben?', 36)
       = IDYES then
    begin
      Resign;
      frmsolution.ShowModal;
      newgame;
    end
  end
  else newgame;
end;

procedure TForm1.SchwierigkeitsgradClick(Sender: TObject);
begin
  //Ruft frmoptions auf und setzt die Optionen
  FrmOptions.SetParams(AnzFarben, FarbWiederholung);
  //Abfragen ob man OK oder Cancel gedrückt hat
  if (frmoptions.ShowModal = mrOK)
  and (frmoptions.ParamsChanged(AnzFarben, FarbWiederholung)) then
  begin
    if (not sbtry.Enabled) or (versuche = 0) or
      (application.MessageBox
      ('Spiel Neu Starten?', 'Spiel Neu Starten?', 36) = IDYES)
    then begin
      FrmOptions.GetParams(AnzFarben, FarbWiederholung);
      UpdateStatusBar;
      reg.saveoptions(FarbWiederholung,AnzFarben);
      newgame;
    end;
  end;
end;

procedure TForm1.answerClick(Sender: TObject);
begin
  //Aufgeben und die Lösung anzeigen (frmsolution)
  Resign;
  frmsolution.Show;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //Das Form kann erst geschlossen werden wenn man Ja klickt
  canclose :=
           application.MessageBox('Spiel Verlassen?', 'Verlassen?', 36) = IDYES;
end;

procedure TForm1.HighScores1Click(Sender: TObject);
begin
  //HighScores aus der Registry lesen und dann anzeigen
  reg.ReadScores;
  reg.WriteScores;
  Frm_HS.ShowModal;
end;

end.

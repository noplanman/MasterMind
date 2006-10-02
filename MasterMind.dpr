program MasterMind;

uses
  Forms,
  main in 'main.pas' {Form1},
  GlobalDefinitions in 'GlobalDefinitions.pas',
  Utils in 'Utils.pas',
  Solution in 'Solution.pas' {frmsolution},
  Success in 'Success.pas' {frmsuccess},
  Options in 'Options.pas' {frmoptions},
  Reg in 'Reg.pas',
  HighScores in 'HighScores.pas' {Frm_HS},
  HighScoreNameEntry in 'HighScoreNameEntry.pas' {Frm_HSNE};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrmsolution, frmsolution);
  Application.CreateForm(Tfrmsuccess, frmsuccess);
  Application.CreateForm(Tfrmoptions, frmoptions);
  Application.CreateForm(TFrm_HS, Frm_HS);
  Application.CreateForm(TFrm_HSNE, Frm_HSNE);
  Application.Run;
end.

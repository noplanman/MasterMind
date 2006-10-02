program MasterMind;

uses
  Forms,
  main in 'main.pas' {Form1},
  GlobalDefinitions in 'GlobalDefinitions.pas',
  Utils in 'Utils.pas',
  Solution in 'Solution.pas' {frmsolution},
  Success in 'Success.pas' {frmsuccess},
  Options in 'Options.pas' {frmoptions},
  Reg in 'Reg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrmsolution, frmsolution);
  Application.CreateForm(Tfrmsuccess, frmsuccess);
  Application.CreateForm(Tfrmoptions, frmoptions);
  Application.Run;
end.

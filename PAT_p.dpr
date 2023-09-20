program PAT_p;

uses
  Forms,
  PAT_u in 'PAT_u.pas' {Form1},
  FormAdmin in 'Forms\FormAdmin.pas' {Form3},
  FormGebruiker in 'Forms\FormGebruiker.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWelkom, frmWelkom);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.CreateForm(TfrmGebruiker, frmGebruiker);
  Application.Run;
end.

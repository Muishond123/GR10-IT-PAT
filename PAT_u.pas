unit PAT_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Buttons, GIFImg, FormGebruiker, FormAdmin;

type
  TfrmWelkom = class(TForm)
    imgAgtergrond: TImage;
    lblMuishondProtection: TLabel;
    lblWelkom: TLabel;
    pnlWekom: TPanel;
    bbnGaanUit: TBitBtn;
    pnlGebruiker: TPanel;
    pnlAdmin: TPanel;
    procedure pnlGebruikerClick(Sender: TObject);
    procedure bbnGaanUitClick(Sender: TObject);
    procedure pnlAdminClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWelkom: TfrmWelkom;

implementation


{$R *.dfm}

procedure TfrmWelkom.bbnGaanUitClick(Sender: TObject);
begin
 Close;     //Maak die hele program toe
end;

procedure TfrmWelkom.pnlAdminClick(Sender: TObject);
begin
  frmWelkom.Hide; //Steek frmWelkom weg
  frmAdmin.Show; //Wys frmAdmin
end;

procedure TfrmWelkom.pnlGebruikerClick(Sender: TObject);
begin
  frmWelkom.Hide;  //Steek frmWelkom weg
  frmGebruiker.Show;   //Wys frmGebruiker
end;

end.

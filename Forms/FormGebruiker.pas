unit FormGebruiker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, pngimage, GIFImg, Buttons, ComCtrls, FormAdmin, Math, comOBj; //Voeg "comOBj" by

type
  TfrmGebruiker = class(TForm)
    imgAgtergrond: TImage;
    edtNaam: TEdit;
    edtWagwoord: TEdit;
    lblGebruikersnaam: TLabel;
    lblWagwoord: TLabel;
    lblInstruksie2: TLabel;
    lblMuishond: TLabel;
    pnlGebruikersnaam: TPanel;
    imgOog: TImage;
    pnlGebruiker: TPanel;
    pnlSin: TPanel;
    pnlKode: TPanel;
    lblKode: TLabel;
    lblInstruksie: TLabel;
    lblGehoor: TLabel;
    rgpSinne: TRadioGroup;
    rgpSeun: TRadioGroup;
    imgFietsry: TImage;
    bbnGaanUit: TBitBtn;
    bbnGaanTerug: TBitBtn;
    lblGebruiker: TLabel;
    lblGebruiker2: TLabel;
    redKode: TRichEdit;
    pnlKontroleer: TPanel;
    pnlKontroleer2: TPanel;
    edtKode1: TEdit;
    procedure bbnGaanUitClick(Sender: TObject);
    procedure pnlKontroleer2Click(Sender: TObject);
    procedure bbnGaanTerugClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgOogMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlKodeClick(Sender: TObject);
    procedure SayAloud(sText:string);     //Skep n nuwe prosedure
    procedure pnlSinClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pnlKontroleerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGebruiker: TfrmGebruiker;
  ovRead:oleVariant;  //Skep n "oleVariant" veranderlike
  sGenereerdeKode,sKode:string;
  LogFile:textfile;
  const
  sGebruikersnaam='James Bond'; //initialiseer n konstante waarde
  sWagwoord='TheRe@l**7';
implementation
uses
Pat_u;

{$R *.dfm}

procedure TfrmGebruiker.bbnGaanTerugClick(Sender: TObject);
begin
 CloseFile(LogFile);
 self.Close; //Maak die huidige form toe
 frmWelkom.Show;//Wys form welkom
 pnlGebruikersnaam.Show;
 pnlGebruiker.Hide;
 edtNaam.Text:='';
 edtWagwoord.Text:='';
 edtKode1.Text:='' ;
 rgpSinne.ItemIndex:=-1;
 rgpSeun.ItemIndex:=-1;
 sGenereerdeKode:='';
 redKode.Lines.Clear;
end;

procedure TfrmGebruiker.bbnGaanUitClick(Sender: TObject);
begin
Writeln(LogFile,sGebruikersnaam+'het uitgeteken om'+''+TimeToStr(Now));
CloseFile(LogFile);
Application.Terminate ;

end;


procedure TfrmGebruiker.FormCreate(Sender: TObject);
begin
pnlGebruiker.Hide; //Steek paneel gebruiker weg
pnlGebruikersnaam.Show; //Wys paneel gebruikersnaam
end;

procedure TfrmGebruiker.FormShow(Sender: TObject);
begin
(imgFietsry.Picture.Graphic as TGIFImage).Animate:=true;  //kode om die gif leer te speel
(imgFietsry.Picture.Graphic as TGIFImage).AnimationSpeed:=100;  //animasie se spoed
end;

procedure TfrmGebruiker.imgOogMouseUp(Sender: TObject; Button: TMouseButton;  //Wanneer gebruiker die muis los:
  Shift: TShiftState; X, Y: Integer);
begin
  edtWagwoord.PasswordChar:='*'; //sal die wagwoord onsigbaar wees
  imgOog.Picture.LoadFromFile('Hide Password.png'); //n foto van n oop oog wys
end;

procedure TfrmGebruiker.MouseDown(Sender: TObject; Button: TMouseButton; //Wanneer die gebruiker die muis inhou op die foto :
  Shift: TShiftState; X, Y: Integer);
begin
 edtWagwoord.PasswordChar:=#0; //sal die wagwoord sigbaar wees
 imgOog.Picture.LoadFromFile('Show Password.png'); //n foto van n toe oog wys

end;

procedure TfrmGebruiker.pnlKodeClick(Sender: TObject);
var
  I: Integer;
  cKode:char;
begin
 for I := 1 to 10 do      //For loop
 begin
 cKode:=char(RandomRange(32,126));   //kies n ewekansige karakter op die ASCII tabel
 sGenereerdeKode:=sGenereerdeKode+cKode;
 end;
 redKode.Lines.Add(sGenereerdeKode);
end;

procedure TfrmGebruiker.pnlKontroleer2Click(Sender: TObject);
{var
bVlag:boolean;
UandPFile:TextFile;
sLinesGebruikersnaam,sWagwoord:string;
iPos:integer;                 }
begin
{if FileExists('UsernamesEnPasword.txt')=False then
begin
  showmessage('Teks leêr is nie gevind nie!');
  Exit;// as die leêr nie gevind is nie sal daar uit die prosedure getree word
end;

bVlag:=False;
AssignFile(UandPFile,'UsernamesEnPasword.txt'); // gee jou text file veranderlike die waarde van die text file
Reset(UandPFile); //die wyser is nou by die begin van die textfile
while not Eof (UandPFile) and (bVlag=False)do  //die loop gaan loop tot dit aan die einde van text file kom
begin
  Readln(UandPFile,sLine); //die lyn waarop die wyser staan is nou sLine
  iPos:=Pos('#',sLine);
  sGebruikersnaam:=Copy(sLine,1,iPos-1);
  Delete(sLine,1,iPos+1);
  sWagwoord:=sLIne;
  if (edtNaam.Text=sGebruikersnaam)and (edtWagwoord.Text=sWagwoord) then  //As die gebruiker die regte naam en wagwoord tik sal:
 bVlag:=true;
end;
CloseFile(UandPFile); //maak leêr toe
if bVlag=true then
begin
 pnlGebruikersnaam.Hide;  //die gebruikersnaam paneel weggesteek word en
 pnlGebruiker.Show; //die gebruiker paneel sal gewys word
end;}

 if (edtNaam.Text=sGebruikersnaam)and (edtWagwoord.Text=sWagwoord) then  //As die gebruiker die regte naam en wagwoord tik sal:
 begin
 pnlGebruikersnaam.Hide;  //die gebruikersnaam paneel weggesteek word en
 pnlGebruiker.Show; //die gebruiker paneel sal gewys word
 AssignFile(LogFile,'IntekenLeêr.txt');
 Rewrite(LogFile);
 Writeln(LogFile,'Datum en tyd:'+''+FormatDateTime('yyyy-mm-dd',Date));
 Writeln(LogFile,'Gebruiker:'+''+sGebruikersnaam);
 Writeln(LogFile,'Ingeteken teen:'+''+TimeToStr(Now));
end
else
  if Not(edtNaam.Text='') and not (edtNaam.Text=sGebruikersnaam) then
begin
  ShowMessage('Die gebruikersnaam verkeerd');//n boodskap wys wat se dat die gebruikersnaam verkeerd is
  edtNaam.SetFocus;
end;

 if Not(edtWagwoord.Text='') and not (edtWagwoord.Text=sWagwoord) then
begin
  ShowMessage('Die wagwoord is verkeerd');//n boodskap wys wat se dat die wagwoord verkeerd is
  edtWagwoord.SetFocus;
end;


 if (edtNaam.Text='') then //as die gebruiker nie sy gebruikersnaam  invul nie sal:
 begin
 showmessage ('vul asseblief u gebruikersnaam in'); //n boodskap verskyn wat se dat hy dit moet invul
 edtNaam.SetFocus; //die muis outomaties op die gebruikersnaam teks boks wees
 end ;

  if (edtWagwoord.Text='') then //as die gebruiker nie sy wagwoord invul nie sal:
 begin
 showmessage ('vul asseblief u wagwoord in'); //n boodskap verskyn wat se dat hy dit moet invul
 edtWagwoord.SetFocus; //die muis outomaties op die gebruikersnaam teks boks wees
 end;

end;

procedure TfrmGebruiker.pnlKontroleerClick(Sender: TObject);
begin
if (edtKode1.Text=sGenereerdeKode) and (rgpSinne.ItemIndex=0) and (rgpSeun.ItemIndex=3) then
begin
SayAloud('u are verified');
pnlGebruiker.hide;
Writeln(LogFile,sGebruikersnaam+''+'het al die toetse suksesvol voltooi om'+''+DateToStr(Date)+''+TimeToStr(Now));
end
 else
 begin
 Writeln(LogFile,sGebruikersnaam+''+'het nie al die toetse suksesvol voltooi nie op'+''+DateToStr(Date)+''+TimeToStr(Now));
 end;
if not (edtKode1.Text=sGenereerdeKode) then
begin
 showmessage('Probeer weer, u het n verkeerde kode getik.');
 edtKode1.SetFocus;
end;

if not (rgpSinne.ItemIndex=0) then
begin
 showmessage('Probeer weer, u het die verkeerde sin gekies.') ;
 rgpSinne.SetFocus;
end ;

 if not (rgpSeun.ItemIndex=3) then
 begin
 showmessage('Probeer weer, u het die verkeerde aktiwiteit wat die seun doen gekies.  ');
 rgpSeun.SetFocus;
 end
end;

procedure TfrmGebruiker.pnlSinClick(Sender: TObject);
begin
SayAloud('Billy built a house.');  //gebruik die "SayAloud" prosedure
end;



procedure TfrmGebruiker.SayAloud(sText: string);
begin
ovRead:=CreateOleObject('SAPI.SPVoice');  //maak n "OleObject"
 ovRead.speak(sText);   //gebruik "speak" metode
end;

end.

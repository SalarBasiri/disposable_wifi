unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls , DelphiZXIngQRCode , shellapi , ClipBrd ;

type
  TForm1 = class(TForm)
    cmbEncoding: TComboBox;
    Label1: TLabel;
    edtText: TEdit;
    Label2: TLabel;
    edtQuietZone: TEdit;
    Label3: TLabel;
    PaintBox1: TPaintBox;
    ssid_edit: TEdit;
    password_edit: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    generate_btn: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Timer1: TTimer;
    step_label: TLabel;
    Creat_btn: TButton;
    Button1: TButton;
    Button2: TButton;
    procedure edtTextChange(Sender: TObject);
    procedure cmbEncodingChange(Sender: TObject);
    procedure edtQuietZoneChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PaintBox1Paint(Sender: TObject);
    procedure generate_btnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Creat_btnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
    QRCodeBitmap: TBitmap;
  public
    { Public declarations }
    procedure Update;
    procedure generate_ssid_password;
    procedure generate_poweshell_and_bat_script;
    procedure execute_batch_file;
    procedure generate_QR_code;
  end;

var
  Form1: TForm1;
  qr_code_str : string;
  my_ssid , my_password : string;
  i , j : integer;

  //shell execute variables
  FileName, Parameters, Folder, Directory: string;
  sei: TShellExecuteInfo;
  Error: DWORD;
  OK: boolean;
  my_file : text;
  my_path : string;
  my_str : string;

  step_counter : integer;

implementation

{$R *.dfm}

procedure TForm1.generate_ssid_password;
begin
  //generate ssid and password
randomize();
my_ssid := '';
my_password := '';
for i := 1 to 8 do
  my_ssid := my_ssid + chr(65 + random(25));
form1.ssid_edit.Text := my_ssid;

for i := 1 to 8 do
begin
randomize();
  my_password := my_password + chr(48 + random(9));
  my_password := my_password + chr(65 + random(25));
  my_password := my_password + chr(97 + random(25));
end;

form1.password_edit.Text := my_password;

end;


procedure TForm1.generate_poweshell_and_bat_script;
begin
//generate powershell script

form1.memo3.Lines.Clear;
for i  := 0 to memo1.Lines.Count-1 do
  form1.memo3.Lines.Add(form1.memo1.Lines[i]);


//$configuration.Ssid = "test"
//$configuration.Passphrase = "12345678"
form1.memo3.Lines.Add('$configuration.Ssid = "'+my_ssid+'"');
form1.memo3.Lines.Add('$configuration.Passphrase = "'+my_password+'"');

for i  := 0 to memo2.Lines.Count-1 do
  form1.memo3.Lines.Add(memo2.Lines[i]);


form1.memo3.Lines.SaveToFile(my_path+'\wifi_script.ps1');


AssignFile(my_file,my_path+'\wifi.bat');
rewrite(my_file);
writeln(my_file,'@ECHO OFF');
my_str := 'Powershell.exe -executionpolicy bypass -File  '+my_path+'\wifi_script.ps1';
writeln(my_file,my_str);
closefile(my_file);


end;


procedure TForm1.execute_batch_file;
begin
// execute batch file to execute powershell

      FileName := my_path+'\wifi.bat';
      Parameters := 'open.';
      ZeroMemory(@sei, SizeOf(sei));
      sei.cbSize := SizeOf(sei);
      sei.lpFile := PChar(FileName);
      sei.lpParameters := PChar(Parameters);
      sei.lpDirectory := PChar(Folder);
      sei.nShow := SW_SHOWNORMAL;
      OK := ShellExecuteEx(@sei);


      deletefile(my_path+'\wifi_script.ps1');
      deletefile(my_path+'\wifi.bat');

end;

procedure TForm1.generate_QR_code;
begin

//Generate QR Code

//WIFI:S:MySSID;T:WPA;P:MyPassW0rd;;
//WIFI:S:<SSID>;T:<WEP|WPA|blank>;P:<PASSWORD>;H:<true|false|blank>;;
qr_code_str := '';
qr_code_str := qr_code_str + 'WIFI:S:';
qr_code_str := qr_code_str + ssid_edit.Text;
qr_code_str := qr_code_str + ';T:WPA;P:';
qr_code_str := qr_code_str + password_edit.Text;
qr_code_str := qr_code_str + ';;';
edtText.Text := qr_code_str;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
Clipboard.AsText := password_edit.Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
Clipboard.AsText := ssid_edit.Text;

end;

procedure TForm1.cmbEncodingChange(Sender: TObject);
begin
  Update;
end;

procedure TForm1.Creat_btnClick(Sender: TObject);
begin
// current path
//my_path := GetCurrentDir();
my_path := 'c:';

step_counter := 2;
timer1.Enabled := true;
end;

procedure TForm1.edtQuietZoneChange(Sender: TObject);
begin
  Update;
end;

procedure TForm1.edtTextChange(Sender: TObject);
begin
  Update;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QRCodeBitmap.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  QRCodeBitmap := TBitmap.Create;
  Update;
  //form1.Left := trunc((screen.DesktopWidth - form1.Width)/2);
  form1.Left := trunc((monitor.Width - form1.Width)/2);
    form1.top := trunc((monitor.Height - form1.Height)/2);
end;

procedure TForm1.generate_btnClick(Sender: TObject);
begin

generate_ssid_password;
generate_QR_code;






end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
  Scale: Double;
begin
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
  if ((QRCodeBitmap.Width > 0) and (QRCodeBitmap.Height > 0)) then
  begin
    if (PaintBox1.Width < PaintBox1.Height) then
    begin
      Scale := PaintBox1.Width / QRCodeBitmap.Width;
    end else
    begin
      Scale := PaintBox1.Height / QRCodeBitmap.Height;
    end;
    PaintBox1.Canvas.StretchDraw(Rect(0, 0, Trunc(Scale * QRCodeBitmap.Width), Trunc(Scale * QRCodeBitmap.Height)), QRCodeBitmap);
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

//if step_counter = 1 then generate_ssid_password;
//if step_counter = 2 then generate_QR_code;

if step_counter = 3 then generate_poweshell_and_bat_script;;

if step_counter = 4 then execute_batch_file;




step_label.Caption := inttostr(step_counter);
step_counter := step_counter + 1;

if step_counter > 4 then
begin
timer1.Enabled := false;
      if Ok then Showmessage('Wifi Hotspot has been created , Scan QR Code.')
      else Showmessage('Error in Creating WiFi Hotspot.');

end;



end;

procedure TForm1.Update;
var
  QRCode: TDelphiZXingQRCode;
  Row, Column: Integer;
begin
  QRCode := TDelphiZXingQRCode.Create;
  try
    QRCode.Data := edtText.Text;
    QRCode.Encoding := TQRCodeEncoding(cmbEncoding.ItemIndex);
    QRCode.QuietZone := StrToIntDef(edtQuietZone.Text, 4);
    QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
    for Row := 0 to QRCode.Rows - 1 do
    begin
      for Column := 0 to QRCode.Columns - 1 do
      begin
        if (QRCode.IsBlack[Row, Column]) then
        begin
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clBlack;
        end else
        begin
          QRCodeBitmap.Canvas.Pixels[Column, Row] := clWhite;
        end;
      end;
    end;
  finally
    QRCode.Free;
  end;
  PaintBox1.Repaint;
end;
end.

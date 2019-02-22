unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
  Vcl.ComCtrls, my_client;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    RichEdit1: TRichEdit;
    Button3: TButton;
    Edit3: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
  private
    my_client: TMy_Client;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if my_client <> nil then
    my_client.Destroy;
  my_client := TMy_Client.Create(Edit1.Text, StrToInt(Edit2.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if my_client <> nil then
    my_client.Destroy;
  Application.Terminate;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if my_client <> nil then
    my_client.Send(Edit3.Text);
  Edit3.Text := '';
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if my_client <> nil then
    my_client.Destroy;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if my_client <> nil then
    my_client.Destroy;
  my_client := TMy_Client.Create(Edit1.Text, StrToInt(Edit2.Text));
end;

end.

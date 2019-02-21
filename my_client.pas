unit my_client;

interface

uses
  System.Win.ScktComp, System.SysUtils;

type TMy_Client = class
  public
    constructor Create(host: String; port: integer);
    Destructor  Destroy;
    procedure FOnConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FOnError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FOnRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FonDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Send(message: String);

  private
    ClientSock: TClientSocket;
    id: String;


end;

implementation

uses Unit1;

constructor TMy_Client.Create(host: string; port: Integer);
begin
  if ClientSock <> nil then
    ClientSock.Destroy;

  ClientSock := TClientSocket.Create(nil);
  ClientSock.Port := port;
  ClientSock.Host := host;
  ClientSock.OnConnect := FOnConnect;
  ClientSock.OnDisconnect := FOnDisconnect;
  ClientSock.OnRead := FOnRead;
  ClientSock.OnError := FOnError;
  ClientSock.Open;
end;

Destructor TMy_Client.Destroy;
begin
  ClientSock.Active := false;
  ClientSock.Destroy;
end;


procedure TMy_Client.FOnConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Form1.RichEdit1.Lines.Add('Client has connected to ' + self.ClientSock.Host + ':' + IntToStr(self.ClientSock.Port));
end;

procedure TMy_Client.FOnError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Form1.RichEdit1.Lines.Add('Socket error ('+IntToStr(ErrorCode)+')');
end;

procedure TMy_Client.FOnRead(Sender: TObject; Socket: TCustomWinSocket);
var message: String;
begin
  message := Socket.ReceiveText;
  Form1.RichEdit1.Lines.Add(message);
end;

procedure TMy_Client.FonDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  Form1.RichEdit1.Lines.Add('Disconnected from Server :(');
end;

procedure TMy_Client.Send(message: string);
begin
  ClientSock.Socket.SendText(message);
end;

end.

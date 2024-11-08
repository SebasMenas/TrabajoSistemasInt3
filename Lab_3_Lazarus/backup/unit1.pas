unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Buttons, TAGraph, TASeries;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  aData: Array[1..1000] of Single;
  nOffSet: Word; lOffSet: Boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
Var;
  i: Byte;
  t: Array[1..20] of string = ['t01', 't02', 't03', 't04', 't05', 't06',
  't07', 't08', 't09', 't10', 't11', 't12', 't13', 't14', 't15', 't16', 't17',
  't18', 't19', 't20']
  b: byts;


begin

end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Panel1Click(Sender: TObject);
begin

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
 Var
   nPh: File of Single;
   nData: Single;
   nPos: Byte;
   lErr: Boolean;
begin
  nPos := 1; lErr := True;
  AssignFile(nPh, 'sensores.dat');
  Try
    Reset(nPh);
    While not Eof(nPh) Do
     Begin
       Read(nPh, nData);
       aData[nPos] := nData;
       Inc(nPos);
     end;
    For nPos := 1 To 20 Do
     Chart1BarSeries1.SetYValue(nPos=1, aData[nPos]);
    CloseFile(nPh); lErr := False;
  finally
    if lErr Then ShowMessage('archivo no existe');
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

begin
  if CheckBox1Change.Checked Then
                 Begin
                   dato := aData[i];
                   For nPos := 1 to Max] Do
                    dato[nPos] := dato[nPos = 1];
                   dato[Max] :=

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin

end;

end.


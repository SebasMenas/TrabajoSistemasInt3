unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Buttons, TAGraph, TASeries, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TSpeedButton;
    Button2: TSpeedButton;
    Chart1: TChart;
    Chart1BarSeries1: TBarSeries;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Panel1: TPanel;
    barrita: TProgressBar;
    SpeedButton1: TSpeedButton;
    StaticText1: TStaticText;
    Timer1: TTimer;
    TrackBar1: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure barritaContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    procedure CargarDatos;
  public

  end;

var
  Form1: TForm1;
  aData: array[1..1000] of Single;
  totalDatos: Integer;
  indiceActual: Integer;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormCreate(Sender: TObject);
begin
  // Inicializamos variables
  totalDatos := 0;
  indiceActual := 1;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.barritaContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;


procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.CargarDatos;
var
  archivo: File of Single;
  dato: Single;
begin

  AssignFile(archivo, 'sensores.dat');
  try
    Reset(archivo);
    totalDatos := 0;

    while (not Eof(archivo)) do
    begin
      Read(archivo, dato);
      aData[totalDatos] := dato;
      Inc(totalDatos);
    end;
    For totalDatos := 1 To 20 Do
     Chart1BarSeries1.AddY(aData[indiceActual], IntToStr(indiceActual));
    CloseFile(archivo);
  except
    ShowMessage('no existe el archivo');
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  CargarDatos;
  indiceActual := 1;
  Chart1BarSeries1.Clear;
  Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i : Integer;
begin

  begin
    if CheckBox1.Checked then
    begin
      For i := 1 To 1000 Do
       aData[i] := aData[i + 1];
      Chart1BarSeries1.Clear;
      For i := 1 to 20 Do
       Chart1BarSeries1.AddY(aData[i], IntToStr(i));

      barrita.Position := barrita.Position + 1;
      if barrita.position = barrita.Max Then
      Begin
        barrita.position := 1;
        CheckBox1.Checked := False;
      end;
  end
  else
  begin
    Timer1.Enabled := False;
  end;
end;
end;
procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  case TrackBar1.Position of
  1: Timer1.Interval := 800;
  2: Timer1.Interval := 600;
  3: Timer1.Interval := 400;
  4: Timer1.Interval := 200;
  5: Timer1.Interval := 100;
  end;
end;


end.


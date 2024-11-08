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
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  totalDatos := 0;
  indiceActual := 1;
  // Configuración inicial del gráfico
  Chart1BarSeries1.Clear;
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  // Puedes agregar alguna lógica aquí si lo necesitas
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

    while (not Eof(archivo)) and (totalDatos < Length(aData)) do
    begin
      Read(archivo, dato);
      Inc(totalDatos);
      aData[totalDatos] := dato;
    end;
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
begin
  if indiceActual <= totalDatos then
  begin
    // Agregar el nuevo dato al gráfico
    Chart1BarSeries1.AddY(aData[indiceActual], IntToStr(indiceActual));

    // Aumentar el índice para leer el siguiente dato
    Inc(indiceActual);

    // Limitar el número de barras visibles (en este caso 20)
    if Chart1BarSeries1.Count > 20 then
    begin
      Chart1BarSeries1.Delete(0);  // Eliminar el primer valor para mantener el tamaño de la serie
    end;

    // Ajustar el eje X para mantener solo las últimas 20 entradas visibles
    if Chart1BarSeries1.Count > 0 then
      Chart1.BottomAxis.SetMinMax(0, Chart1BarSeries1.Count);
  end
  else
  begin
    // Detener el temporizador cuando se acaben los datos
    Timer1.Enabled := False;
  end;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  // Ajuste del intervalo del temporizador según el TrackBar
  case TrackBar1.Position of
    5: Timer1.Interval := 100;
  end;
end;

end.


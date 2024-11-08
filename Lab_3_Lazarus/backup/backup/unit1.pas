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
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure CargarDatos;
  public

  end;

var
  Form1: TForm1;
  aData: array[1..1000] of Single;  // Almacena los datos de temperatura
  totalDatos: Integer;              // Cantidad de datos cargados
  indiceActual: Integer;            // Índice actual para el temporizador

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Inicializamos variables
  totalDatos := 0;
  indiceActual := 1;
end;

procedure TForm1.CargarDatos;
var
  archivo: File of Single;
  dato: Single;
begin
  // Intentamos abrir el archivo binario
  AssignFile(archivo, 'sensores.dat');
  try
    Reset(archivo);
    totalDatos := 0;
    // Leemos cada valor de temperatura y lo guardamos en el arreglo
    while (not Eof(archivo)) and (totalDatos < Length(aData)) do
    begin
      Read(archivo, dato);
      Inc(totalDatos);
      aData[totalDatos] := dato;
    end;
    CloseFile(archivo);
  except
    ShowMessage('No se pudo abrir el archivo "sensores.dat".');
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  // Cargamos los datos y reiniciamos el índice del temporizador
  CargarDatos;
  indiceActual := 1;
  Chart1BarSeries1.Clear;  // Limpiamos la gráfica
  Timer1.Enabled := True;  // Iniciamos el temporizador para actualizar el gráfico
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if indiceActual <= totalDatos then
  begin
    // Agregamos el valor actual al gráfico en formato de barra
    Chart1BarSeries1.AddY(aData[indiceActual], IntToStr(indiceActual));
    Inc(indiceActual);  // Avanzamos al siguiente índice
  end
  else
  begin
    // Deshabilitamos el temporizador si se completaron los datos
    Timer1.Enabled := False;
  end;
end;

end.


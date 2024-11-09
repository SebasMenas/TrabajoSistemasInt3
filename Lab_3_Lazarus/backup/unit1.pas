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
    //Inicializar funciones de la aplicacion
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
  //Datos de el archivo, seran 1000 y en tipo Single
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


//Boton de salir
procedure TForm1.Button1Click(Sender: TObject);
//si se presiona, cierra la app
begin
  Close;
end;


//funcion cargar los datos
procedure TForm1.CargarDatos;
var
  archivo: File of Single; //Asi llamaremos a una variable que tendra el archivo cargado, file of single es que almacena varios datos single en el
  dato: Single; //Representa cada dato leido
begin

  AssignFile(archivo, 'sensores.dat') //Asignamos a la variable el sensores.dat;
  //manejo errores
  try
    Reset(archivo);  //Abrir el sensores.dat
    totalDatos := 0;

    while (not Eof(archivo)) do //Mientras no este vacio, se ejecuta este bucle... EOF significa End of File
    begin
      Read(archivo, dato); //Leer cada dato del archivo como un Single
      aData[totalDatos] := dato; //almacenar el valor dato(single) en la posición del aData
      Inc(totalDatos); //Pasar al siguiente
    end;
    For totalDatos := 1 To 20 Do //Itera 20 veces
     Chart1BarSeries1.AddY(aData[indiceActual], IntToStr(indiceActual)); //en cada iteracion agrega un valor al grafico (el inttostr es para convertir el num en texto, puede q sirva para las etiquetas)
    CloseFile(archivo); //cerrar archivo
  except
    ShowMessage('no existe el archivo');
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject); //boton cargar data
begin
  CargarDatos; //llamar la funcion cargardatos
  indiceActual := 1; //el indice inicial sera 1
  Chart1BarSeries1.Clear; //limpiamos el grafico
  Timer1.Enabled := True; //activamos el timer para ir dato por dato
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i : Integer; //i como entero
begin

  begin
    if CheckBox1.Checked then //si esta marcada la casilla de scrolling entonces
    begin
      For i := 1 To 1000 Do //interar 1000 veces
       aData[i] := aData[i + 1]; //ira recorriendo dato por dato
      Chart1BarSeries1.Clear; //limpia grafico
      For i := 1 to 20 Do //itera 20 veces
       Chart1BarSeries1.AddY(aData[i], IntToStr(i)); //para el scrolling, agrega datos al y

      barrita.Position := barrita.Position + 1; //la barra de progreso va aumentando
      if barrita.position = barrita.Max Then  //si la barra de progreso llega al final entonces
      Begin
        barrita.position := 1; //vuelve a posicion 1
        CheckBox1.Checked := False; //casilla scrolling se desactiva
      end;
  end
  else
  begin
    Timer1.Enabled := False; //timer se apaga
  end;
end;
end;
procedure TForm1.TrackBar1Change(Sender: TObject); //para la velocidad del timer
begin
  case TrackBar1.Position of //si la posiciion del trackbar esta en
  1: Timer1.Interval := 800; //1, el timer estara en 800
  2: Timer1.Interval := 600; //2, el timer estara en 600
  3: Timer1.Interval := 400; //3, el timer estara en 400
  4: Timer1.Interval := 200; //4, el timer estara en 200
  5: Timer1.Interval := 100; //5, el timer estara en 100
  end;
end;


end.

//fin

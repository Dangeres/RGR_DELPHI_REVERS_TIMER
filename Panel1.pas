unit Panel1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, System.Actions,
  Vcl.ActnList, Vcl.Buttons, Vcl.Menus, Vcl.ExtCtrls;

type
  // наш компонент который унаследовал все свойства от класса TPanel
  ReverseTimerComp = class(TPanel)
  private
    //i - инкапсулированнная переменная которая считает секунды до конца отсчета
    i:integer;
    //элементы которые присутствуют в нашем компоненте
    timer : TTimer;
    edit  : TEdit;
    button : TButton;
  public
    //конструктор для нашего компонента
    constructor Create(Towner : TComponent); override;
    //действие для обработки ежесекундно для нашего таймера
    procedure myEvent(Sender: TObject);
    //функция которая обрабатывает клик по кнопке
    procedure clicked(Sender: TObject);
  published
    //свойство для обращения к нашим секундам
    property seconds: integer read i write i;
  end;

procedure Register;

implementation

procedure Register;
begin
  //создаем вкладку Timer, где будет валяться наш компонент
  RegisterComponents('Timer', [ReverseTimerComp]);
end;

constructor ReverseTimerComp.Create(Towner : TComponent);
begin
  //исполняем сначала коструктор предка
  inherited create(towner);
  self.width := 185;
  self.height := 65;

  //создаем таймер на компоненте и делаем его настройку, далее по аналонии
  timer := TTimer.Create(self);
  timer.Interval := 1000;

  edit := TEdit.Create(self);
  edit.Height:=21;
  edit.Width:=121;
  edit.top:=4;
  edit.left:=48;
  edit.Text:='0';
  edit.Parent := self;
  edit.Visible:=true;

  button := TButton.Create(self);
  button.height:=25;
  button.width:=75;
  button.top:=31;
  button.left:=72;
  button.Caption:='Отсчет!';
  button.Parent := self;
  button.Visible:=true;
  //это деленирование функции - определяем что наша функция обрабатывающая клик по кнопке - clicked. В лазарусе может потребовать поставить "@" перед функцией т.е @clicked
  button.OnClick:=clicked;
end;

procedure ReverseTimerComp.clicked(Sender: TObject);
begin
  seconds:=StrToInt(Edit.Text);
  Timer.Enabled := True;
  self.timer.OnTimer:= myEvent;
  Edit.Enabled := False;
end;

procedure ReverseTimerComp.myEvent(Sender: TObject);
begin
  seconds:=seconds-1;
  Edit.Text := IntToStr(seconds);
  if seconds<=0 then begin
    //выдаем звуковой сигнал об окончании отсчета
    MessageBeep(MB_ICONEXCLAMATION);
    Timer.Enabled:=false;
    Edit.Enabled := true;
  end;
end;

end.

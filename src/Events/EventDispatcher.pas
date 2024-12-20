unit EventDispatcher;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  TEventCallback = reference to procedure(Data: TObject);

  TEventDispatcher = class
  private
    FListeners: TObjectDictionary<String, TList<TEventCallback>>;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Subscribe(EventName: String; Callback: TEventCallback);
    procedure Dispatch(EventName: String; Data: TObject);
  end;

implementation

{ TEventDispatcher }

constructor TEventDispatcher.Create;
begin
  FListeners := TObjectDictionary<String, TList<TEventCallback>>.Create([doOwnsValues]);
end;

destructor TEventDispatcher.Destroy;
begin
  FListeners.Free;
  inherited;
end;

procedure TEventDispatcher.Dispatch(EventName: String; Data: TObject);
begin
  if FListeners.ContainsKey(EventName) then
    for var LCallback in FListeners[EventName] do
      LCallback(Data);
end;

procedure TEventDispatcher.Subscribe(EventName: String;
  Callback: TEventCallback);
begin
  if not FListeners.ContainsKey(EventName) then
    FListeners.Add(EventName, TList<TEventCallback>.Create);
  FListeners[EventName].Add(Callback);
end;

end.

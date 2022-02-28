unit sCollections;


interface

type
    
    class function TPair<TKey, TValue>.Create(AKey: TKey;AValue: TValue): TPair<TKey, TValue>;
    begin
        Result.Key := AKey;
        Result.Value := AValue;
    end;

implementation

end.
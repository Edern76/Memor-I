unit GameLogic;

interface

uses Common;

procedure RetourneCarte(j : Integer; var carte : TCard);

function Victoire(g : TGrid) : Boolean;


var cartePrecedente : TCard ;
	nbPaire : Integer;

implementation

{Retourne une carte et verifie si une paire a ete formee}
procedure RetourneCarte(j : Integer; var carte: TCard);

var c : TCard;
var i : Integer;


	BEGIN
		i:=0;
		if (not carte.Revealed) then
			BEGIN
			carte.Revealed := True;
			writeln('Carte retournee');
			END;
		if i=0 then
			BEGIN
			inc(i);
			END
		else
			BEGIN
			if i=1 then
				carte.Selected := True;
			
			if carte.CardType = cartePrecedente.CardType then
				begin
				end;
			END
		
	END;

{Verifie si la partie est gagnée, c'est-a-dire, si toutes les cartes sont retournees}
function Victoire(g : TGrid) : Boolean;
	BEGIN
	
	END;
	
	
END.


unit GameLogic;

interface
uses Common;

procedure RetourneCarte(var carte : TCard);

function Victoire(g : Grid) : Boolean;


var cartePrecedente : TCard ;
	nbPaire : Integer;

implementation

{Retourne une carte et verifie si une paire a ete formee}
procedure RetourneCarte(j : Integer; var carte: TCard);

var c : TCard;
var i : Integer;


	BEGIN
		i:=0;
			if i=0 then
				inc(i);
			else
			
			if i=1 then
				carte.Selected := True;
		
		if carte.CardType = cartePrecedente.CardType then
			begin
			end;
			
		
	END;

{Verifie si la partie est gagnée, c'est-a-dire, si toutes les cartes sont retournees}
function Victoire(g : Grid) : Boolean;
	BEGIN
	
	END;
	
{}
procedure 
	BEGIN
	
	
	END;
	
END.


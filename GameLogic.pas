unit GameLogic;

interface

uses Common;

procedure RetourneCarte(var carte : TCard; var t : Grid);

function Victoire(i,j : Integer; g : Grid) : Boolean;


var cartePrecedente : TCard ; //Faudrait initialiser avec une valeur bullshit
	nbPaire : Integer;

implementation

{Retourne une carte et verifie si une paire a ete formee}
procedure RetourneCarte(var carte: TCard;  var t : Grid);
	var x,y : Integer;
	
	BEGIN
		if (not carte.Selected) then
			BEGIN
			carte.Selected := True;
			writeln('Carte retournee');
			END;
			
		if carte.CardType = cartePrecedente.CardType then
			begin
				nbPaire := nbPaire + 1;
				carte.Revealed := True;
				x := cartePrecedente.x;
				y := cartePrecedente.y;
				t[x][y].Revealed := True;
				
			end;
			
		
	END;

{Verifie si la partie est gagnée, c'est-a-dire, si toutes les cartes sont retournees}
function Victoire(i,j : Integer; g : Grid) : Boolean;
	BEGIN
	i:=0; j:=0;
	repeat
		inc(i);
		repeat
			inc(j);
			
		until j = GetDim;
			
	until (g[i][j].Revealed = False) OR ((i=GetDim()) AND (j=GetDim()));
					
			
			
	END;
	
	
END.


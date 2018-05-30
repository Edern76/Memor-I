unit GameLogic;

interface

uses Common;

function RetourneCarte(var carte : TCard) : Boolean;

function Victoire(i,j : Integer; g : Grid) : Boolean;


var cartePrecedente : TCard ; //Faudrait initialiser avec une valeur bullshit
	nbPaire : Integer;

implementation

{Retourne une carte et verifie si une paire a ete formee}
function RetourneCarte(var carte: TCard) : Boolean;
	var x,y : Integer;
	
	BEGIN
		if ((not t[carte.x][carte.y].Selected) and (not t[carte.x][carte.y].Revealed)) then
			BEGIN
			{writeln('Revelee avant ' , carte.Revealed);
			writeln('Select avant', carte.Selected);
			writeln('TRevelee avant ' , t[carte.x][carte.y].Revealed);
			writeln('TSelect avant', t[carte.x][carte.y].Selected);}
			t[carte.x][carte.y].Selected := True;
			{writeln('Carte retournee');
			writeln('Revelee apres ' , carte.Revealed);
			writeln('Select apres ', carte.Selected);
			writeln('TRevelee apres ' , t[carte.x][carte.y].Revealed);
			writeln('TSelect apres', t[carte.x][carte.y].Selected);}
			
				if (carte.CardType.Name = cartePrecedente.CardType.Name) then
					begin
						nbPaire := nbPaire + 1;
						t[carte.x][carte.y].Revealed := True;
						x := cartePrecedente.x;
						y := cartePrecedente.y;
						t[x][y].Revealed := True;
						cartePrecedente := rien;
						RetourneCarte := True;
					end
				else
					BEGIN
					if (cartePrecedente.CardType.Name <> rien.CardType.Name) then
						BEGIN
						writeln('Type 1 :', carte.CardType.Name);
						writeln('Type 2 :', cartePrecedente.CardType.Name);
						RetourneCarte := False;
						cartePrecedente := rien;
						END
					else
						BEGIN
						writeln('Type 1 :', carte.CardType.Name);
						writeln('Type 2 (normalement rien) :', cartePrecedente.CardType.Name);
						RetourneCarte := True;
						cartePrecedente := carte;
						END;
				END;
			END;
			
		
			
		
	END;

{Verifie si la partie est gagnée, c'est-a-dire, si toutes les cartes sont retournees}
function Victoire(i,j : Integer; g : Grid) : Boolean;
	BEGIN
	i:=0; j:=0;
	repeat
		inc(i);
		while (g[i][j].Revealed = True) do
			repeat
				inc(j);
			until j=GetDim();

		if i = GetDim() then
			begin
			end;
	until (True);				
			
			
	END;
	
	
END.


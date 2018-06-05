unit GameLogic;

interface

uses Common, ScoreIO;

function RetourneCarte(var carte : TCard) : Boolean;

function Victoire() : Boolean;


var cartePrecedente : TCard ; //Faudrait initialiser avec une valeur bullshit
	nbCoups : Integer;

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
						nbCoups := nbCoups + 1;
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
						nbCoups := nbCoups + 1;
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
function Victoire() : Boolean;
	var i,j : Integer;
	BEGIN		
	Victoire := True;
	for i := 0 to GetDim() - 1 do
		for j := 0 to GetDim() - 1 do
			BEGIN
			if (not t[i][j].Revealed) then
				BEGIN
				Victoire := False;
				break;
				END;
			END;
	END;
	
END.


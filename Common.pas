Unit Common;
//Unité commmune aux deux parties du programme, contenant des types représentant les cartes et le terrain de jeu, ainsi que quelques fonctions utiles pour les manipuler.


interface
const MAX_DIM = 6; //Selon la consigne, on joue avec un maximum de 36 cartes, on aura donc besoin au maximum d'un carré de 6 de côté pour la grille
const MAX_TYPES = 18; // Comme on aura au maximum 36 cartes, on aura besoin au maximum de 18 types de carte différents	

{Par convention en Pascal les définitions de structures sont précédées de la lettre T, pour éviter toute confusion possible avec le nom d'une variable ou avec de simples tableaux}
{Le type d'une carte, à savoir le symbole qu'elle contient et son nom. Deux cartes forment une paire si et seulement si leurs types sont identiques}
Type TCardType = record
	Name : String;
	ImgPath : String; //Chemin de l'image représentant la carte face révélée. L'image face cachée sera une constante définie en dehors de cette unité. Utilisé seulement pour l'interface en théorie
end;

Type TCoord = record
	x, y : Integer;
end;

{Une carte individuelle en elle même. Contient sa position, son statut et son type (voir plus haut)}
Type TCard = record
	x, y : Integer;
	Revealed, Selected : Boolean; //Si Selected est vraie, alors on affiche la carte de manière temporaire (jusqu'au prochain coup), si revealed est vraie alors la carte a été définitivement retournée, on l'affiche alors face visible pour le restant de la partie
	CardType : TCardType;
end;

{Type servant à la disposition initiale des cartes lors d'une nouvelle partie, correspondant à un choix possible de carte}
Type TCardChoice = record
	UsesLeft : Integer; //Le nombre de fois que l'on peut encore placer ce type de carte. Commence à 2, réduit de 1 à chaque fois que l'on place une carte de ce type, ce qui permet donc de s'assurer que l'on aura jamais plus de deux cartes d'un même type. 
	CardType : TCardType;
end;

{Liste de toutes les cartes que l'on peut encore placer sans avoir plus d'une paire de chaque}
Type PossibleChoices = array of TCardChoice; //Taille volontairement omise, cela crée un tableau dont on peut modifier la taille avec la procédure SetLength(tableau, taille) implémentée de base en Pascal (donc pas Goblet of Fire)

{Grille sur laquelle sont disposées les cartes}
Type Grid = array[0..MAX_DIM - 1, 0..MAX_DIM-1] of TCard; //Oui, j'aime quand les tableaux commencent à 0 (et c'est surtout plus pratique parce que random est indexé à 0)

{Tous les types de cartes}
Type CardTypes = array[0..MAX_TYPES] of TCardType;

Type PBool = ^Boolean;

{Crée le tableau renfermant tous les types de cartes possibles et imaginables}
function InitTypes() : CardTypes;

{Crée la liste des types de cartes à mettre sur la grille}
{@param types : Tableau des types possibles, crée avec InitTypes}
{@param easy : Vrai si l'utilisateur joue avec 16 cartes, faux si il joue avec 36}	
function InitChoices(types : CardTypes) : PossibleChoices;

{Retire un élément à une position donnée d'un tableau}
procedure RemoveFromArray(var arr : PossibleChoices; index : Integer);

{Obtiens un type de carte aléatoire de la liste des choix restants, et modifie celle-ci en conséquence}
procedure RandomCard(var choices : PossibleChoices; var chosenType : TCardType);

procedure CreateRien(types : CardTypes) ;

operator = (t1, t2 : TCardType) b : Boolean;

{Crée la zone de jeu et dispose les cartes}
function CreateGrid(choices : PossibleChoices) : Grid;
function GetDim() : Integer;
procedure ClearSelect();

var easy, win, quit : Boolean;
	rien : TCard;
	t : Grid;
	dispWTime : Integer;

implementation

operator = (t1, t2 : TCardType) b : Boolean;
	BEGIN
	if ((t1.Name = t2.Name) and (t1.ImgPath = t2.ImgPath)) then
		BEGIN
		b := True;
		END
	else
		BEGIN
		b := False
		END
	END;

function GetDim() : Integer;
	BEGIN
	if (easy) then
		BEGIN
		GetDim := 4;
		END
	else
		BEGIN
		GetDim := 6;
		END;
	END;
	
procedure CreateRien(types : CardTypes);
	BEGIN
	rien.x := -1;
	rien.y := -1;
	rien.Revealed := False;
	rien.Selected := False;
	rien.CardType := types[18];
	END;
	
function InitTypes() : CardTypes;
	BEGIN
	//Pas une boucle car à terme, les cartes auront probablement des noms/noms de fichier plus expressifs que TestN.png
	//Facile : Devs + Jokers + Debut rangee de devant
	//Difficile : Facile + le reste
	InitTypes[0].Name := 'Martin';
	InitTypes[0].ImgPath := 'Test0.png';
	InitTypes[1].Name := 'Miruna';
	InitTypes[1].ImgPath := 'Test1.png';
	InitTypes[2].Name := 'Ugo';
	InitTypes[2].ImgPath := 'Test2.png';
	InitTypes[3].Name := 'Gawein';
	InitTypes[3].ImgPath := 'Test3.png';
	InitTypes[4].Name := 'Edouard';
	InitTypes[4].ImgPath := 'Test4.png';
	InitTypes[5].Name := 'Lea';
	InitTypes[5].ImgPath := 'Test5.png';
	InitTypes[6].Name := 'Marie';
	InitTypes[6].ImgPath := 'Test6.png';
	InitTypes[7].Name := 'Joker'; //Remplacer par Joker 2
	InitTypes[7].ImgPath := 'Test7.png';
	InitTypes[8].Name := 'Clubs';
	InitTypes[8].ImgPath := 'Test8.png';
	InitTypes[9].Name := 'Diamonds';
	InitTypes[9].ImgPath := 'Test9.png';
	InitTypes[10].Name := 'Hearts';
	InitTypes[10].ImgPath := 'Test10.png';
	InitTypes[11].Name := 'Spades';
	InitTypes[11].ImgPath := 'Test11.png';
	InitTypes[12].Name := 'Axel';
	InitTypes[12].ImgPath := 'Test12.png';
	InitTypes[13].Name := 'Ionela';
	InitTypes[13].ImgPath := 'Test13.png';
	InitTypes[14].Name := 'Gabriel';
	InitTypes[14].ImgPath := 'Test14.png';
	InitTypes[15].Name := 'Mathias';
	InitTypes[15].ImgPath := 'Test15.png';
	InitTypes[16].Name := 'Maxime';
	InitTypes[16].ImgPath := 'Test16.png';
	InitTypes[17].Name := 'Romain';
	InitTypes[17].ImgPath := 'Test17.png';
	InitTypes[18].Name := 'Rien';
	InitTypes[18].Name := 'Rien.png';
	END;
	
function InitChoices(types: CardTypes) : PossibleChoices;
	var i, maxI : Integer;
	BEGIN
	if (easy) then
		BEGIN
		maxI := 8;
		END
	else
		BEGIN
		maxI := 18;
		END;
	
	for i:=0 to maxI-1 do
		BEGIN
		SetLength(InitChoices, i+1); //On change la taille du tableau InitChoices, afin de pouvoir la récupérer facilement avec Length() après
		InitChoices[i].UsesLeft := 2; //On veut exactement deux cartes de chaque type
		InitChoices[i].CardType := types[i];
		END
	END;
	
procedure RemoveFromArray(var arr : PossibleChoices; index : Integer);
	var prevLen, i : Integer;
	BEGIN
	prevLen := Length(arr);
	for i:= index to(prevLen - 2) do // Dernier indice du tableau = prevLen - 1 (index basé à zero), donc prevLen - 2 = avant-dernier, qui correspondra au dernier du tableau réduit
		BEGIN
		arr[i] := arr[i+1]; //On décale toute les valeurs du tableau, en écrasant au passage celle que l'on veut supprimer.
		END;
	SetLength(arr,  prevLen - 1); //On réduit la taille effective de 1
	END;
	
procedure RandomCard(var choices : PossibleChoices; var chosenType : TCardType);
	var index, max : Integer;
	BEGIN
	max := Length(choices);
	index := Random(max); //On détermine le numéro du type à choisir
	choices[index].UsesLeft := choices[index].UsesLeft - 1;
	chosenType := choices[index].CardType;
	if (choices[index].UsesLeft = 0) then
		BEGIN
		RemoveFromArray(choices, index); //Si on a placé deux cartes d'un type, on le retire des types possibles
		END
	END;
	
function CreateGrid(choices : PossibleChoices) : Grid;
	var maxDim, i, j : Integer;
	BEGIN
	if (easy) then
		BEGIN
		maxDim := 4; // Carré de 4x4
		END
	else
		BEGIN
		maxDim := 6; // Carré de 6x6
		END;
	
	for i:= 0 to maxDim-1 do
		for j:=0 to maxDim-1 do
			BEGIN
			RandomCard(choices, CreateGrid[i][j].CardType);
			CreateGrid[i][j].x := i;
			CreateGrid[i][j].y := j;
			CreateGrid[i][j].Revealed := False;
			CreateGrid[i][j].Selected := False;
			END;
			
	for j:= maxDim-1 downto 0 do
		BEGIN
		for i:=0 to maxDim-1 do
			BEGIN
			write(CreateGrid[i][j].CardType.Name, ' ');
			END;
		writeln();
		END;
	END;
	
procedure ClearSelect();
	var i,j, dim : Integer;
	BEGIN
	dim := GetDim();
	for i:= 0 to dim-1 do
		for j:=0 to dim-1 do
			t[i][j].Selected := False;
	
	END;
END.


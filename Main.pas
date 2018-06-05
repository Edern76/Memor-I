{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image, ScoreIO;

const DEFAULT_WAIT = 10000;

var window : PSDL_SURFACE;
	types : CardTypes;
	noRedraw : Boolean;
	
procedure DisplayScores();
	var i : Integer;
		arr : Leaderboard;
	BEGIN
	arr := LoadLeaderboards();
	for i:=0 to MAX_SCORES - 1 do
		BEGIN
		if (arr[i].score <> -1) then
			BEGIN
			writeln(i+1);
			writeln('Name : ', arr[i].name);
			writeln('Score : ', arr[i].score);
			END;
		END;
	END;

procedure CreateGame();
	BEGIN
	randomize();
	nbCoups := 0;
	easy := True;
	win := False;
	quit := False;
	noRedraw := True;
	G_sprites := LoadSprites();
	types := InitTypes();
	dispWTime := DEFAULT_WAIT;
	dispWTime := 1000;
	curX := 0;
	curY := 0;
	CreateRien(types);
	cartePrecedente := rien;
	InitMouse();
	InitScoreIO();
	t := CreateGrid(InitChoices(types));
	END;
	
procedure PlayGame();
	var scoreIndex : Integer;
		arr : Leaderboard;
		score : THighScore;
	BEGIN
	repeat
		SDL_Delay(20); //Limite le jeu à une valeur fixe de FPS, problème d'inputs dédoublés sinon.
		SDL_FillRect(window, 0,0);
		DrawGrid(window, t);
		if (not noRedraw) then
			BEGIN
			DrawCursor(window, curX, curY);
			SDL_Flip(window);
			SDL_Delay(500);
			ClearSelect();
			SDL_FillRect(window, 0,0);
			DrawGrid(window, t);
			END;
		DrawCursor(window, curX, curY);
		SDL_Flip(window);
		noRedraw := GetInput();
		win := Victoire();
	until (win or quit);

	if quit then
		BEGIN
		writeln('Quitted program');
		SDL_Freesurface(window);
		SDL_Quit();
		END;

	
	if win then
		BEGIN
		writeln('A winner is you !');
		SDL_FillRect(window, 0,0);
		DrawGrid(window, t);
		DrawCursor(window, curX, curY);
		
		arr := LoadLeaderboards();
		scoreIndex := GetPossibleIndex(arr, nbCoups);
		if (scoreIndex <> -1) then
			BEGIN
			DrawSprite(window, GetSprite('High'), (WIDTH - FRAME_WIDTH) div 2, (HEIGHT - FRAME_HEIGHT) div 2, FRAME_WIDTH, FRAME_HEIGHT);
			SDL_Flip(window);
			writeln('Veuillez entrer votre nom');
			readln(score.name);
			score.score := nbCoups;
			AddScore(arr, score, scoreIndex);
			writeln('Classement : ', scoreIndex + 1);
			SaveLeaderboards(arr);
			END
		else
			BEGIN
			DrawSprite(window, GetSprite('NoHigh'), (WIDTH - FRAME_WIDTH) div 2, (HEIGHT - FRAME_HEIGHT) div 2, FRAME_WIDTH, FRAME_HEIGHT);
			SDL_Flip(window);
			END
		END;
	END;
BEGIN
window := InitRender();
G_sprites := LoadSprites();
createGame();
displayScores();
playGame();
END.


{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;

const DEFAULT_WAIT = 10000;

var window : PSDL_SURFACE;
	types : CardTypes;
	noRedraw : Boolean;
	
procedure CreateGame();
	BEGIN
	randomize();
	nbCoups := 0;
	easy := False;
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
	t := CreateGrid(InitChoices(types));
	END;
	
procedure PlayGame();
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
	until (win or quit);

	if quit then
		BEGIN
		writeln('Quitted program');
		SDL_Freesurface(window);
		SDL_Quit();
		END;
	END;

BEGIN
window := InitRender();
createGame();
playGame();
END.


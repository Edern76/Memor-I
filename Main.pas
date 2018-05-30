{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;

const DEFAULT_WAIT = 10000;

var window : PSDL_SURFACE;
	types : CardTypes;
	noRedraw : Boolean;

BEGIN
randomize();
G_sprites := LoadSprites();
window := InitRender();
types := InitTypes();
easy := False;
win := False;
quit := False;
noRedraw := True;
dispWTime := DEFAULT_WAIT;
dispWTime := 1000;
curX := 0;
curY := 0;
CreateRien(types);
cartePrecedente := rien;
//SDL_SetRenderDrawColor(window, 255, 255; 255, SDL_ALPHA_OPAQUE);
//SDL_RenderClear(window);
t := CreateGrid(InitChoices(types));
repeat
	SDL_Delay(33); //Limite le jeu à 60 FPS, problème d'inputs dédoublés sinon.
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

END.


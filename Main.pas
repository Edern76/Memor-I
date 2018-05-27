{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;
	win, quit : Boolean;

BEGIN
G_sprites := LoadSprites();
window := InitRender();
easy := False;
win := False;
quit := False;
curX := 0;
curY := 0;
//SDL_SetRenderDrawColor(window, 255, 255; 255, SDL_ALPHA_OPAQUE);
//SDL_RenderClear(window);

repeat
	SDL_Delay(33); //Limite le jeu à 60 FPS, problème d'inputs dédoublés sinon.
	SDL_FillRect(window, 0,0);
	DrawGrid(window, CreateGrid(InitChoices(InitTypes())));
	DrawCursor(window, curX, curY);
	SDL_Flip(window);
	GetInput(win, quit);
until (win or quit);

if quit then
	BEGIN
	writeln('Quitted program');
	SDL_Freesurface(window);
	SDL_Quit();
	END;

END.


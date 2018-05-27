{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;
	easy, win, quit : Boolean;

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
	DrawGrid(window, CreateGrid(InitChoices(InitTypes(), easy), easy), easy);
	DrawCursor(window, curX, curY, easy);
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


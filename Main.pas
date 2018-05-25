{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;
	easy : Boolean;

BEGIN
G_sprites := LoadSprites();
window := InitRender();
easy := False;
//SDL_SetRenderDrawColor(window, 255, 255; 255, SDL_ALPHA_OPAQUE);
//SDL_RenderClear(window);
DrawGrid(window, CreateGrid(InitChoices(InitTypes(), easy), easy), easy);
SDL_Flip(window);
readln();

END.


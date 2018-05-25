{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;
	sprites : SpritesList;
	easy : Boolean;

BEGIN
sprites := LoadSprites();
window := InitRender();
easy := False;
//SDL_SetRenderDrawColor(window, 255, 255; 255, SDL_ALPHA_OPAQUE);
//SDL_RenderClear(window);
DrawGrid(window, CreateGrid(InitChoices(InitTypes(), easy), easy), easy, sprites);
SDL_Flip(window);
SDL_delay(4000);

END.


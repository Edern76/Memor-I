{$mode delphi}
program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;
	sprites : SpritesList;

BEGIN
sprites := LoadSprites();
window := InitRender();
//SDL_SetRenderDrawColor(window, 255, 255; 255, SDL_ALPHA_OPAQUE);
//SDL_RenderClear(window);
DrawSprite(window, sprites[0], 0, 0);
SDL_Flip(window);
SDL_delay(4000);

END.


program Main;

uses GameLogic, GUI, Common, sdl, sdl_image;


var window : PSDL_SURFACE;

BEGIN
window := InitRender();
SDL_Flip(window);
SDL_delay(4000);

END.


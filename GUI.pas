unit GUI;

interface
uses Common, sdl, sdl_image;

function InitRender() : PSDL_SURFACE;

implementation

function InitRender() : PSDL_SURFACE;
	BEGIN
	SDL_Init(SDL_INIT_VIDEO);
	
	InitRender := SDL_SETVIDEOMODE(1280, 720, 32, SDL_HWSURFACE);
	END;

END.



{$mode delphi}
unit GUI;

interface
uses Common, sdl, sdl_image;

const MAX_SPRITES = 100;
const SPRITE_DEFAULT_HEIGHT = 120;
const SPRITE_DEFAULT_WIDTH = 80;


Type Sprite = record
	Name : String;
	Image : PSDL_SURFACE;
end;

Type SpritesList = array[0..100] of Sprite;

function InitRender() : PSDL_SURFACE;
function LoadSprites() : SpritesList;

procedure GetInput();

procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer);



implementation

function InitRender() : PSDL_SURFACE;
	BEGIN
	SDL_Init(SDL_INIT_VIDEO);
	
	InitRender := SDL_SETVIDEOMODE(1280, 720, 32, SDL_HWSURFACE);
	END;
	
function LoadSprites() : SpritesList;
	BEGIN
	LoadSprites[0].Name := 'TestBack';
	LoadSprites[0].Image := IMG_Load('Images/TestBack.png');
	END;
	
procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer);
	var destination: TSDL_RECT;
	BEGIN
	destination.x := x;
	destination.y := y;
	destination.w := SPRITE_DEFAULT_WIDTH;
	destination.h := SPRITE_DEFAULT_HEIGHT;
	
	SDL_BlitSurface(sprite.Image, NIL, window, @destination);
	END;
	
procedure GetInput();
	BEGIN
	
	
	END;

END.



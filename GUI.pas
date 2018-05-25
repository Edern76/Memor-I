{$mode delphi}
unit GUI;

interface
uses Common, sdl, sdl_image;

const MAX_SPRITES = 100;
const HEIGHT = 720;
const WIDTH = 1280;
const SPRITE_DEFAULT_HEIGHT = 120;
const SPRITE_DEFAULT_WIDTH = 80;
const V_PADDING = 10;
const H_PADDING = 50;


Type Sprite = record
	Name : String;
	Image : PSDL_SURFACE;
end;

Type SpritesList = array[0..100] of Sprite;

function InitRender() : PSDL_SURFACE;
function LoadSprites() : SpritesList;

procedure GetInput();

procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer);

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid; easy : Boolean; sprites : SpritesList);



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
	
procedure DrawGrid(window : PSDL_SURFACE; grid : Grid; easy : Boolean; sprites : SpritesList);
	var x,y,i,j, dim, startX, startY, totX, totEndX, totalWidth, totY, totEndY, totalHeight : Integer;
	BEGIN
	if (easy) then
		BEGIN
		dim := 4;
		END
	else
		BEGIN
		dim := 6;
		END;
	startX := 20;
	startY := 20;
	
	for j := 1 to dim do
		for i := 1 to dim do
			BEGIN
			totalWidth := dim * (SPRITE_DEFAULT_WIDTH + H_PADDING);
			startX := (WIDTH - totalWidth) div 2;
			totX := ((WIDTH - 2*startX) - totalWidth) div 2;
			totEndX := totX + totalWidth;
			x := (totEndX div dim) * i;
			writeln(totX);
			totalHeight := dim * (SPRITE_DEFAULT_HEIGHT + V_PADDING);
			startY := (HEIGHT - totalHeight) div 2;
			totY := ((HEIGHT - 2*startY) - totalHeight) div 2;
			totEndY := totY + totalHeight;
			y := (totEndY div dim) * j;
			DrawSprite(window, sprites[0], x,y);
			END
	
	END;

END.



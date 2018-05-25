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
const H_PADDING = 5;


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
	var x,y,i,j, dim, startX, startY, offX, offY, totX, totEndX, totalWidth, totY, totEndY, totalHeight, remainWidth, remainHeight, actualTotalWidth : Integer;
	BEGIN
	if (easy) then
		BEGIN
		dim := 4;
		END
	else
		BEGIN
		dim := 6;
		END;
	offX := 5;
	offY := 20;
	
	actualTotalWidth := WIDTH - 2*offX;
	totalWidth := dim * (SPRITE_DEFAULT_WIDTH + H_PADDING);
	remainWidth := (actualTotalWidth - totalWidth) div dim;//((WIDTH - 2*offX) div dim) - (SPRITE_DEFAULT_WIDTH + H_PADDING);
	
	writeln(totalWidth);
	writeln(WIDTH - 2*offX);
	writeln((WIDTH-2*offX) div dim);
	writeln(remainWidth);
	for j := 1 to dim do
		for i := 0 to dim-1 do
			BEGIN

			startX := (WIDTH div 2) - actualTotalWidth;
			x := startX + i*((totalWidth div dim + remainWidth)) ;
{
			totX := ((WIDTH - 2*startX) - actualtotalWidth) div 2;
			totEndX := totX + totalWidth;
			x := (totEndX div dim) * i;
			writeln(totX);
			totalHeight := dim * (SPRITE_DEFAULT_HEIGHT + V_PADDING);
			startY := ((HEIGHT - totalHeight) div 2);
			totY := ((HEIGHT - 2*startY) - totalHeight) div 2;
			totEndY := totY + totalHeight;
			y := (totEndY div dim) * j;
}
			DrawSprite(window, sprites[0], x,0);
			END
	
	END;

END.



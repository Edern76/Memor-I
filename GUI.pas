{$mode delphi}
unit GUI;

interface
uses Common, sdl, sdl_image;

const MAX_SPRITES = 100;
const HEIGHT = 900;
const WIDTH = 1280;
const SPRITE_DEFAULT_HEIGHT = 120;
const SPRITE_DEFAULT_WIDTH = 80;
const V_PADDING = 20;
const H_PADDING = 80;

const X_BIAS = 20;
const Y_BIAS = 10;


Type Sprite = record
	Name : String;
	Image : PSDL_SURFACE;
end;

Type SpritesList = array[0..100] of Sprite;

function InitRender() : PSDL_SURFACE;
function LoadSprites() : SpritesList;

procedure GetInput(var win, quit : Boolean);

procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer)  overload;
procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y, width, height : Integer)  overload;

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid; easy : Boolean);

var G_sprites : SpritesList;

implementation

function InitRender() : PSDL_SURFACE;
	BEGIN
	SDL_Init(SDL_INIT_VIDEO);
	
	InitRender := SDL_SETVIDEOMODE(WIDTH, HEIGHT, 32, SDL_HWSURFACE);
	END;
	
function LoadSprites() : SpritesList;
	BEGIN
	LoadSprites[0].Name := 'TestBack';
	LoadSprites[0].Image := IMG_Load('Images/TestBack.png');
	END;

	
procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer)  overload;
	var destination: TSDL_RECT;
	BEGIN
	destination.x := x;
	destination.y := y;
	destination.w := SPRITE_DEFAULT_WIDTH;
	destination.h := SPRITE_DEFAULT_HEIGHT;
	
	SDL_BlitSurface(sprite.Image, NIL, window, @destination);
	END;
	
procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y, width, height: Integer)  overload;
	var destination: TSDL_RECT;
	BEGIN
	destination.x := x;
	destination.y := y;
	destination.w := width;
	destination.h := height;
	
	SDL_BlitSurface(sprite.Image, NIL, window, @destination);
	END;
	
procedure GetInput(var win, quit : Boolean);
	var event : PSDL_EVENT;
	BEGIN
	
	
	SDL_PollEvent(event);
	
	case event.type_ of
		SDL_QUITEV : quit := True;
		
	END;
	END;



function GridToGlobalCoords(x,y : Integer; easy : Boolean) : TCoord;
	var totalWidth, startX, totalHeight, startY, dim : Integer;
	BEGIN
	if (easy) then
		BEGIN
		dim := 4;
		END
	else
		BEGIN
		dim := 6;
		END;
		
	totalWidth := (dim * (SPRITE_DEFAULT_WIDTH + H_PADDING)) - H_PADDING;
	startX := ((WIDTH - totalWidth) div 2) + X_BIAS;
	totalHeight := (dim *(SPRITE_DEFAULT_HEIGHT + V_PADDING)) - V_PADDING;
	startY := ((HEIGHT - totalHeight) div 2) + Y_BIAS;
	
	GridToGlobalCoords.x := startX + x*(totalWidth div dim) ;
	GridToGlobalCoords.y := startY + y*(totalHeight div dim);
	
	
	END;

procedure DrawCard(window : PSDL_SURFACE; easy : Boolean; card : TCard);
	var pos : TCoord;
		cSprite : Sprite;
	BEGIN

	
	if (card.Revealed or card.Selected) then
		BEGIN
		//Select sprite corresponding to card image once they are implemented
		cSprite := G_Sprites[0]; // PLACEHOLDER
		END
	else
		BEGIN
		cSprite := G_Sprites[0]; //Card back
		END;
	pos := GridToGlobalCoords(card.x, card.y, easy);
	DrawSprite(window, cSprite, pos.x, pos.y);
	END;

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid; easy : Boolean);
	var i,j,dim : Integer;
	BEGIN
	if (easy) then
		BEGIN
		dim := 4;
		END
	else
		BEGIN
		dim := 6;
		END;

	for j := 0 to dim-1 do
		for i := 0 to dim-1 do
			BEGIN		
			DrawCard(window, easy, grid[i][j]);
			END
	
	END;

END.



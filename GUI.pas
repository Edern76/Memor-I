{$mode delphi}
unit GUI;

interface
uses Common, sdl, sdl_image;

const MAX_SPRITES = 100;
const HEIGHT = 900;
const WIDTH = 1280;
const SPRITE_DEFAULT_HEIGHT = 120;
const SPRITE_DEFAULT_WIDTH = 80;

const CURSOR_WIDTH = 2;
const CURSOR_HEIGHT = 2;

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

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid);
procedure MoveCursor(dx, dy : Integer);

function GridToGlobalCoords(x,y : Integer) : TCoord;
function GetDim(easy : boolean) : Integer;
function GetSprite(name : String) : Sprite;

procedure DrawCursor(window : PSDL_SURFACE; x,y : Integer);

var G_sprites : SpritesList;
	curX, curY : Integer;

implementation

function InitRender() : PSDL_SURFACE;
	BEGIN
	SDL_Init(SDL_INIT_VIDEO);
	SDL_EnableKeyRepeat(1000, 100);
	
	InitRender := SDL_SETVIDEOMODE(WIDTH, HEIGHT, 32, SDL_HWSURFACE);
	END;
	
function LoadSprites() : SpritesList;
	BEGIN
	LoadSprites[0].Name := 'TestBack';
	LoadSprites[0].Image := IMG_Load('Images/TestBack.png');
	LoadSprites[1].Name := 'Cursor';
	LoadSprites[1].Image := IMG_Load('Images/Cursor.png');
	END;

function GetDim(easy : boolean) : Integer;
	BEGIN
	if (easy) then
		BEGIN
		GetDim := 4;
		END
	else
		BEGIN
		GetDim := 6;
		END;
	END;
	
function GetSprite(name : String) : Sprite;
	var i : Integer;
		found : Boolean;
	BEGIN
	found := False;
	for i:= 0 to 100 do
		BEGIN
		if (G_sprites[i].Name = name) then
			BEGIN
			GetSprite := G_sprites[i];
			found := True;
			break;
			END
		END;
	if (not found) then
		writeln('ERROR : Could not find sprite named ', name);
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
	//273 : UP
	//274 : DOWN
	//275 : RIGHT
	//276 : LEFT
	var event : PSDL_EVENT;
	BEGIN
	SDL_PollEvent(event);
	
	case event.type_ of
		SDL_QUITEV : quit := True;
		SDL_KEYDOWN : 
			BEGIN
			writeln(event.key.keysym.sym);
			case event.key.keysym.sym of
				273 : MoveCursor(0, -1);
				274 : MoveCursor(0, 1);
				275 : MoveCursor(1, 0);
				276 : MoveCursor(-1, 0);
			END;
			END
		
	END;
	END;



function GridToGlobalCoords(x,y : Integer) : TCoord;
	var totalWidth, startX, totalHeight, startY, dim : Integer;
	BEGIN
	dim := GetDim(easy);
		
	totalWidth := (dim * (SPRITE_DEFAULT_WIDTH + H_PADDING)) - H_PADDING;
	startX := ((WIDTH - totalWidth) div 2) + X_BIAS;
	totalHeight := (dim *(SPRITE_DEFAULT_HEIGHT + V_PADDING)) - V_PADDING;
	startY := ((HEIGHT - totalHeight) div 2) + Y_BIAS;
	
	GridToGlobalCoords.x := startX + x*(totalWidth div dim) ;
	GridToGlobalCoords.y := startY + y*(totalHeight div dim);
	
	
	END;

procedure DrawCard(window : PSDL_SURFACE; card : TCard);
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
		cSprite := GetSprite('TestBack'); //Card back
		END;
	pos := GridToGlobalCoords(card.x, card.y);
	DrawSprite(window, cSprite, pos.x, pos.y);
	END;
	
procedure DrawCursor(window : PSDL_SURFACE; x,y : Integer);
	var cardPos : TCoord;
		actualX, actualY : Integer;
	BEGIN
	cardPos := GridToGlobalCoords(x, y);
	actualX := cardPos.X - CURSOR_WIDTH;
	actualY := cardPos.Y - CURSOR_HEIGHT;
	
	DrawSprite(window, GetSprite('Cursor'), actualX, actualY);
	
	END;
	
procedure MoveCursor(dx, dy : Integer);
	var dim : Integer;
	BEGIN
	dim := GetDim(easy);
	if ((dx >= 0) and (curX < (dim - 1))) then
		curX := curX + dx;
	if ((dx <= 0) and (curX > 0)) then
		curX := curX + dx;
	if ((dy >= 0) and (curY < (dim - 1))) then
		curY := curY + dy;
	if ((dy <= 0) and (curY > 0)) then
		curY := curY + dy;
	
	END;

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid);
	var i,j,dim : Integer;
	BEGIN

	dim := GetDim(easy);
	
	for j := 0 to dim-1 do
		for i := 0 to dim-1 do
			BEGIN		
			DrawCard(window, grid[i][j]);
			END
	END;

END.



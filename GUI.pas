{$mode delphi}
unit GUI;

interface
uses Common, sdl, sdl_image, sdl_ttf, GameLogic, SysUtils;

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

Type TRange = record
	start : TCoord;
	stop : TCoord;
end;

Type RangeList = array[0..5,0..5] of TRange;


function InitRender() : PSDL_SURFACE;
procedure InitMouse();
function LoadSprites() : SpritesList;

function GetInput() : Boolean;

procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y : Integer)  overload;
procedure DrawSprite(window : PSDL_SURFACE; sprite : Sprite; x,y, width, height : Integer)  overload;

procedure DrawGrid(window : PSDL_SURFACE; grid : Grid);
procedure MoveCursor(dx, dy : Integer);

function GridToGlobalCoords(x,y : Integer) : TCoord;
function GetSprite(name : String) : Sprite;
function GetRange() : RangeList;

procedure DrawCursor(window : PSDL_SURFACE; x,y : Integer);


var G_sprites : SpritesList;
	curX, curY : Integer;
	cardRanges : RangeList;
	font : pointer;
	colorFont, colorFont2 : TSDL_COLOR;
	counter : PSDL_SURFACE;

implementation
procedure InitMouse();
	BEGIN
	cardRanges := GetRange();
	END;

function InitRender() : PSDL_SURFACE;
	BEGIN
	SDL_Init(SDL_INIT_VIDEO);
	SDL_EnableKeyRepeat(4000, 50000);
	TTF_Init();
	colorFont.r := 255; colorFont.g := 255; colorFont.b:=255;
	font := TTF_OpenFont('Poppins-BoldItalic.ttf', 12);
	InitRender := SDL_SETVIDEOMODE(WIDTH, HEIGHT, 32, SDL_HWSURFACE);
	SDL_WM_SetCaption('Memor-I', 'MemorI');
	END;
	
function LoadSprites() : SpritesList;
	BEGIN
	LoadSprites[0].Name := 'TestBack';
	LoadSprites[0].Image := IMG_Load('Images/Card back.png');
	LoadSprites[1].Name := 'Cursor';
	LoadSprites[1].Image := IMG_Load('Images/Cursor.png');
	LoadSprites[2].Name := 'Edouard';
	LoadSprites[2].Image := IMG_Load('Images/Edouard of Clubs.png');
	LoadSprites[3].Name := 'Gawein';
	LoadSprites[3].Image := IMG_Load('Images/G of Diamonds.png');
	LoadSprites[4].Name := 'Gabriel';
	LoadSprites[4].Image := IMG_Load('Images/Gabriel of Spades.png');
	LoadSprites[5].Name := 'Ionela';
	LoadSprites[5].Image := IMG_Load('Images/Ionela of Hearts.png');
	LoadSprites[6].Name := 'Marie';
	LoadSprites[6].Image := IMG_Load('Images/Joker Marie.png');
	LoadSprites[7].Name := 'Martin';
	LoadSprites[7].Image := IMG_Load('Images/Martin of Clubs.png');
	LoadSprites[8].Name := 'Mathias';
	LoadSprites[8].Image := IMG_Load('Images/Mathias of Hearts.png');
	LoadSprites[9].Name := 'Maxime';
	LoadSprites[9].Image := IMG_Load('Images/Maxime of Diamonds.png');
	LoadSprites[10].Name := 'Miruna';
	LoadSprites[10].Image := IMG_Load('Images/Miruna of Hearts.png');
	LoadSprites[11].Name := 'Romain';
	LoadSprites[11].Image := IMG_Load('Images/Romain of Clubs.png');
	LoadSprites[12].Name := 'Ugo';
	LoadSprites[12].Image := IMG_Load('Images/U of Spades.png');
	LoadSprites[13].Name := 'Lea';
	LoadSprites[13].Image := IMG_Load('Images/Lea of Spades.png');
	LoadSprites[14].Name := 'Clubs';
	LoadSprites[14].Image := IMG_Load('Images/Ace of Clubs.png');
	LoadSprites[15].Name := 'Diamonds';
	LoadSprites[15].Image := IMG_Load('Images/Ace of Diamonds.png');
	LoadSprites[16].Name := 'Hearts';
	LoadSprites[16].Image := IMG_Load('Images/Ace of Hearts.png');
	LoadSprites[17].Name := 'Spades';
	LoadSprites[17].Image := IMG_Load('Images/Ace of Spades.png');
	LoadSprites[18].Name := 'Axel';
	LoadSprites[18].Image := IMG_Load('Images/Axel of Diamonds.png');
	LoadSprites[19].Name := 'Joker';
	LoadSprites[19].Image := IMG_Load('Images/Joker.png');
	LoadSprites[20].Name := 'Background';
	LoadSprites[20].Image := IMG_Load('Images/playfield_resize.png');
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
	
function GetInput() : Boolean;
	//273 : UP
	//274 : DOWN
	//275 : RIGHT
	//276 : LEFT
	var event : PSDL_EVENT;
		mX, mY, i, j, dim : Integer;
		r : TRange;
	BEGIN
	GetInput := True;
	dim := GetDim();
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
				13 : GetInput := RetourneCarte(t[curX][curY]);
			END;
			END;
		SDL_MOUSEMOTION :
			BEGIN
			mX := event.motion.x;
			mY := event.motion.y;
			for i:=0 to dim do
				for j:=0 to dim do
					BEGIN
					r := cardRanges[i][j];
					if (((mX >= r.start.x) and (mX <= r.stop.x)) and ((mY >= r.start.y) and (mY <= r.stop.y))) then
						BEGIN
						writeln('Mouse over card at ', i, ';', j);
						curX := i;
						curY := j;
						break;
						END;
					END;
			END;
		SDL_MOUSEBUTTONDOWN:
			BEGIN
			if (event.button.button = 1) then
				BEGIN
				writeln('Clic gauche');
				GetInput := RetourneCarte(t[curX][curY]);
				END
			END;
	END;
END;
	



function GridToGlobalCoords(x,y : Integer) : TCoord;
	var totalWidth, startX, totalHeight, startY, dim : Integer;
	BEGIN
	dim := GetDim();
		
	totalWidth := (dim * (SPRITE_DEFAULT_WIDTH + H_PADDING)) - H_PADDING;
	startX := ((WIDTH - totalWidth) div 2) + X_BIAS;
	totalHeight := (dim *(SPRITE_DEFAULT_HEIGHT + V_PADDING)) - V_PADDING;
	startY := ((HEIGHT - totalHeight) div 2) + Y_BIAS;
	
	GridToGlobalCoords.x := startX + x*(totalWidth div dim) ;
	GridToGlobalCoords.y := startY + y*(totalHeight div dim);
	
	
	END;
	
function GetRange() : RangeList;
	var relX, relY, dim : Integer;
	BEGIN
	dim := GetDim();
	for relX:=0 to dim-1 do
		for relY:=0 to dim-1 do
			BEGIN
			GetRange[relX][relY].start := GridToGlobalCoords(relX, relY);
			GetRange[relX][relY].stop.x := GridToGlobalCoords(relX, relY).x + SPRITE_DEFAULT_WIDTH;
			GetRange[relX][relY].stop.y := GridToGlobalCoords(relX, relY).y + SPRITE_DEFAULT_HEIGHT;
			END
	END;

procedure DrawCard(window : PSDL_SURFACE; card : TCard);
	var pos : TCoord;
		cSprite : Sprite;
	BEGIN

	
	if (card.Revealed or card.Selected) then
		BEGIN
		//Select sprite corresponding to card image once they are implemented
		cSprite := GetSprite(card.CardType.Name);
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
	dim := GetDim();
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
		nbMoves : String;
		textField : PSDL_RECT;
	BEGIN
	DrawSprite(window, GetSprite('Background'), 0, 0);
	new(textField);
	nbMoves := 'Moves : ' + IntToStr(nbCoups);
	counter := TTF_RENDERTEXT_SOLID(font, PChar(nbMoves), colorFont);
	textField.x := 20;
	textField.y := 5;
	SDL_BLITSURFACE(counter, NIL, window, textField);
	dim := GetDim();
	
	for j := 0 to dim-1 do
		for i := 0 to dim-1 do
			BEGIN		
			DrawCard(window, t[i][j]);
			END
	END;

END.



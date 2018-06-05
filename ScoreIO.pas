Unit ScoreIO;

interface
uses SysUtils, Common;

const MAX_SCORES = 10;

Type THighScore = record
	score : Integer;
	name : String;
end;

Type Leaderboard = array[0..MAX_SCORES - 1] of THighScore;

procedure AddScore(var arr : Leaderboard; score : THighScore; pos : Integer);
procedure InitScoreIO();

function InitLeaderboard() : Leaderboard;
function LoadLeaderboards() : Leaderboard;
procedure SaveLeaderboards(arr : Leaderboard);

function GetPossibleIndex(arr : Leaderboard; score : Integer) : Integer;
procedure ProcessScore(s : THighScore);



var nullScore : THighScore;
	fileName : String;

implementation
procedure InitScoreIO();
	BEGIN
	nullScore.score := -1;
	nullScore.name := 'Null';
	
	if (easy) then
		fileName := 'easyScores.dat'
	else
		fileName := 'hardScores.dat';
	END;

procedure AddScore(var arr : Leaderboard; score : THighScore; pos : Integer);
	var i : Integer;
		tmp : Leaderboard;

	BEGIN
	tmp := InitLeaderboard();
	if (not ((pos >= 0) and (pos <= MAX_SCORES-1))) then
		writeln('ERROR : Invalid score append position');
	
	if (pos = 9) then
		BEGIN
		arr[pos] := score;
		END
	else
		BEGIN
		if (arr[pos].score = -1) then
			BEGIN
			arr[pos] := score;
			END
		else
			BEGIN
			for i:=0 to pos-1 do
				BEGIN
				tmp[i] := arr[i];
				END;
			for i:= pos to MAX_SCORES - 2 do
				BEGIN
				tmp[i+1] := arr[i];
				END;
			tmp[pos] := score;
			arr := tmp;
			END;
		END;
	END;


function InitLeaderboard() : Leaderboard;
	var i : Integer;
	BEGIN
	for i:= 0 to MAX_SCORES - 1 do
		BEGIN
		InitLeaderboard[i] := nullScore;
		END
	END;
	
procedure SaveLeaderboards(arr : Leaderboard);
	var sFile : file of Leaderboard;
	BEGIN
	DeleteFile(fileName);
	assign(sFile, fileName);
	rewrite(sFile);
	write(sFile, arr);
	close(sFile);
	END;

function LoadLeaderboards() : Leaderboard;
	var lFile : file of Leaderboard;
	BEGIN
	if (FileExists(fileName)) then
		BEGIN
		assign(lFile, fileName);
		reset(lFile);
		read(lFile, LoadLeaderboards);
		close(lFile);
		END
	else
		BEGIN
		LoadLeaderboards := InitLeaderboard();
		END;
	END;
	
function GetPossibleIndex(arr : Leaderboard; score : Integer) : Integer;
	var i : Integer;
	BEGIN
	GetPossibleIndex := -1;
	for i:= 0 to MAX_SCORES - 1 do
		BEGIN
		if ((arr[i].score = -1) or (score < arr[i].score)) then
			BEGIN
			GetPossibleIndex := i;
			break;
			END;
		END;
	END;
	
procedure ProcessScore(s : THighScore);
	var arr : Leaderboard;
		ind : Integer;
	BEGIN
	arr := LoadLeaderboards();
	ind := GetPossibleIndex(arr, s.score);
	if (ind <> -1) then
		BEGIN
		AddScore(arr, s, ind);
		END;
	SaveLeaderboards(arr);
	END;

	
end.

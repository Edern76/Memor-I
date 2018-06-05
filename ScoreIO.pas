Unit ScoreIO;

interface
cosnt MAX_SCORES := 10;
Type THighScore = record
	score : Integer;
	name : String;
end;

Type Leaderboard = array[0..MAX_SCORES - 1] of THighScore;

procedure AddScore(var arr : Leaderboard; score : THighScore; pos : Integer);
procedure InitScoreIO();

function InitLeaderboard() : Leaderboard;

var nullScore : THighScore;

implementation
procedure InitScoreIO();
	BEGIN
	nullScore.score := -1;
	nullScore.name := 'Null';
	END;

procedure AddScore(var arr : Leaderboard; score : THighScore; pos : Integer);
	var i : Integer;

	BEGIN
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
			for i:= pos to MAX_SCORES - 2 do
				BEGIN
				arr[i+1] := arr[i];
				END;
			arr[pos] := score;
			END;
		END;
	END;
end.

function InitLeaderboard() : Leaderboard;
	var i : Integer;
	BEGIN
	for i:= 0 to MAX_SCORES - 1 do
		BEGIN
		InitLeaderboard[i] := nullScore;
		END
	END;

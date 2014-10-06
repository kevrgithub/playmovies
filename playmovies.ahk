CoordMode, ToolTip, Screen

Global moviePlayer := "vlc"

Global movies := {}

Global movieFolders := {}

Global movie := ""

Global movieFolder := ""

Global movieIndex := 0

SplashTextOn,320,80,,`nLoading movies...

ParseFolder("d:\torrents\!plab")
ParseFolder("d:\torrents\!pron")

SplashTextOff

;MsgBox % movies.MaxIndex()

PlayRandomMovie()
Return

ParseFolder(folderName)
{
    Loop, %folderName%\*.*, 0, 1
    {
        If A_LoopFileName Contains sample,Sample
        {
            Continue
        }

        If A_LoopFileDir Contains sample,Sample
        {
            Continue
        }

        If A_LoopFileExt In !ut
        {
            Continue
        }

        If A_LoopFileExt In wmv,mp4,mpg,avi,mov,flv,mkv,webm
        {
            movies.Insert(A_LoopFileLongPath)
            movieFolders.Insert(A_LoopFileDir)
        }
    }
}

PlayMovie()
{
    movie := movies[movieIndex]

    movieFolder := movieFolders[movieIndex]

    ;MsgBox, %movie%

    Run, c:\%moviePlayer%\%moviePlayer%.exe "%movie%" :start-time=10

    ;Process, Close, %moviePlayer%.exe
    ;Run, c:\%moviePlayer%\%moviePlayer%.exe "%movie%" --fullscreen --mute=yes --volume=10 --start=10 --loop-file

    ToolTip, %movie%, 0, 0
}

PlayPreviousMovie()
{
    movieIndex := movieIndex - 1

    If (movieIndex < movies.MinIndex())
    {
        movieIndex := movies.MaxIndex()
    }

    PlayMovie()
}

PlayNextMovie()
{
    movieIndex := movieIndex + 1

    If (movieIndex > movies.MaxIndex())
    {
        movieIndex := movies.MinIndex()
    }

    PlayMovie()
}

PlayRandomMovie()
{
    Random, movieIndex, 1, movies.MaxIndex()

    PlayMovie()
}

o::
Run, %movieFolder%
Return

Delete::
FileAppend, %movie%`n, deletemovies.txt
Sleep, 1000
PlayRandomMovie()
Return

Up::
PlayRandomMovie()
Return

Left::
PlayPreviousMovie()
Return

Right::
PlayNextMovie()
Return

Down::
Process, Close, %moviePlayer%.exe
ExitApp
Return

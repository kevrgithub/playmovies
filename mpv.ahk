Global moviePlayer   := "mpv"
Global moviePlaylist := "mpvplaylist.txt"

FileDelete, %moviePlaylist%

;IfNotExist, %moviePlaylist%
;{
    SplashTextOn,320,80,,`nBuilding movies playlist...

    ParseFolder("d:\torrents\!plab")
    ParseFolder("d:\torrents\!pron")

    SplashTextOff
;}

Process, Close, %moviePlayer%.exe
Run, c:\%moviePlayer%\%moviePlayer%.exe "%movie%" --fullscreen --mute=yes --volume=10 --start=10 --playlist=%moviePlaylist% --shuffle --title='${filename}'

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

        If A_LoopFileExt In wmv,mp4,mpg,avi,mov,flv,mkv,webm
        {
            FileAppend, %A_LoopFileLongPath%`n, %moviePlaylist%
        }
    }
}
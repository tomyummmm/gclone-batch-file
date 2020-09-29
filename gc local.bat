@echo off
title Gclone is the best, batch file edited by Tomyummmm, original by RoshanConnor Yo yo (https://telegra.ph/Gclone-Guide-for-Windows-07-20)

color 0b
echo Hey Sexy! Wanna clone some TBs?
echo ----------------------------------------------------------------------------------------------------------------------
echo Configured Team Drives
gclone listremotes
echo ----------------------------------------------------------------------------------------------------------------------
echo off


:menu
echo.
echo 1) COPY
echo 2) MOVE
echo 3) SYNC
echo 4) SIZE
echo 5) CHECK
echo 6) LIST
echo 7) DELETE / PURGE
echo 8) DEDUPE
echo 9) REMOVE EMPTY FOLDERS
echo 10) EMPTY TRASH
echo N) NCDU - Explore a remote with a text based user interface.
echo M) MD5SUM - Produces an md5sum file for all the objects in the path.
echo C) CONFIG
echo Q) EXIT
echo.
set /P option="Choose your Mode: "
if %option% == 1 (goto copy)
if %option% == 2 (goto move)
if %option% == 3 (goto sync)
if %option% == 4 (goto size)
if %option% == 5 (goto check)
if %option% == 6 (goto list)
if %option% == 7 (goto delete)
if %option% == 8 (goto dedp)
if %option% == 9 (goto rmdi)
if %option% == 10 (goto empt)
if /I %option% == N (goto ncdu)
if /I %option% == M (goto md5)
if /I %option% == C (goto config)
if /I %option% == Q (EXIT)
echo.


:copy
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone copy %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=15s --ignore-existing --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu



:move
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone move %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=15s --ignore-existing --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu


:sync
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone sync %src% %dst% --transfers 50 --tpslimit-burst 50 --checkers 10 -vP --stats-one-line --stats=15s --drive-server-side-across-configs --drive-chunk-size 128M --drive-acknowledge-abuse --drive-keep-revision-forever --fast-list
echo.
pause
goto menu


:check
echo.
set /P src="[Enter Source Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
set /P dst="[Enter Destination Folder / TeamDrive] "
gclone check %src% %dst% -P --drive-server-side-across-configs --fast-list
echo.
pause
goto menu


:size
echo.
set /P src="[Enter Folder / TeamDrive] "
gclone size %src% --fast-list
echo.
pause
goto menu


:list
echo.
echo 1) ls           List the objects in the path with size and path.
echo 2) lsd          List all directories/containers/buckets in the path.
echo 3) lsf          List directories and objects in remote:path formatted for parsing
echo 4) lsjson       List directories and objects in the path in JSON format.
echo 5) lsl          List the objects in path with modification time, size and path.
echo 6) tree         List the contents of the remote in a tree like fashion.
echo 7) listremotes  List all the remotes in the config file.
echo.
set /P listtype="Type of List? "
set /P remote="[Enter Folder / TeamDrive] "
echo.
if %listtype% == 1 (gclone ls %remote%)
if %listtype% == 2 (gclone lsd %remote%)
if %listtype% == 3 (gclone lsf %remote%)
if %listtype% == 4 (gclone lsjson %remote%)
if %listtype% == 5 (gclone lsl %remote%)
if %listtype% == 6 (gclone tree %remote%)
if %listtype% == 7 (gclone listremotes)
echo.
pause
goto menu


:delete
echo.
echo 1) delete          Remove the contents of path.
echo 2) deletefile      Remove a single file from remote.
echo 3) purge           Remove the path and all of its contents.
echo.
set /P deletetype="Type of Delete? "
set /P remote="[Enter Folder / TeamDrive] "
echo.
if %deletetype% == 1 (gclone delete %remote% -vP --stats-one-line --stats=15s --fast-list)
if %deletetype% == 2 (gclone deletefile %remote% -vP --stats-one-line --stats=15s --fast-list)
if %deletetype% == 3 (gclone purge %remote% -vP --stats-one-line --stats=15s --fast-list)
echo.
pause
goto menu


:dedp
echo.
set /P src="[Enter Folder / TeamDrive] "
set /p choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto drd)
if /I %choice%==n (goto nodrd)
echo.


:drd
echo ----------------------------------------------------------------------------------------------------------------------
gclone dedupe --dedupe-mode newest %src% -v --dry-run --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed with Dedupe? (y/n) "
if /I %choice%==y (goto nodrd)
if /I %choice%==n (goto menu)
echo.



:nodrd
echo ----------------------------------------------------------------------------------------------------------------------
set /p choice=Do you want to PERMANENTLY delete the duplicates? (y - Permanent / n - Send to trash bin)
if /I %choice%==y (gclone dedupe --dedupe-mode newest %src% -v --drive-use-trash=false --fast-list)
if /I %choice%==n (gclone dedupe --dedupe-mode newest %src% -v --fast-list)
echo.
pause
goto menu


:rmdi
echo.
set /P src="[Enter Folder / TeamDrive] "
set /p choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto drr)
if /I %choice%==n (goto nodrr)
echo.


:drr
echo ----------------------------------------------------------------------------------------------------------------------
gclone rmdirs %src% -v --fast-list --dry-run
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed with Removal of Empty Folders? (y/n) "
if /I %choice%==y (goto nodrr)
if /I %choice%==n (goto menu)
echo.


:nodrr
echo ----------------------------------------------------------------------------------------------------------------------
set /p choice=Do you want to PERMANENTLY delete empty folders? (y - Permanent / n - Send to trash bin)
if /I %choice%==y (gclone rmdirs %src% -v --drive-use-trash=false --fast-list)
if /I %choice%==n (gclone rmdirs %src% -v --fast-list)
echo.
pause
goto menu


:empt
echo.
set /P src="[Enter TeamDrive ID] "
echo ----------------------------------------------------------------------------------------------------------------------
set /p choice="Do you want to do a dry run? (y/n) "
if /I %choice%==y (goto emptdr)
if /I %choice%==n (goto emptnodr)


:emptdr
echo ----------------------------------------------------------------------------------------------------------------------
gclone delete %src% -vP --drive-trashed-only --drive-use-trash=false --fast-list --dry-run
echo ----------------------------------------------------------------------------------------------------------------------
echo off
echo.
set /P choice="Proceed to empty trash? (y/n) "
if /I %choice%==y (goto emptnodr)
if /I %choice%==n (goto menu)


:emptnodr
set /P choice="Are you sure? (y/n) "
if /I %choice%==y (gclone delete %src% -vP --drive-trashed-only --drive-use-trash=false --fast-list)
if /I %choice%==n (goto menu)
echo.
pause
goto menu


:ncdu
echo.
set /P src="[Enter Folder / TeamDrive] "
echo ----------------------------------------------------------------------------------------------------------------------
gclone ncdu %src% --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo.
goto menu


:md5
echo.
echo ----------------------------------------------------------------------------------------------------------------------
set /P remote="[Enter Folder / TeamDrive] "
echo.
gclone md5sum %remote% --fast-list
echo ----------------------------------------------------------------------------------------------------------------------
echo.
pause
goto menu


:config
echo.
echo ----------------------------------------------------------------------------------------------------------------------
gclone config
echo ----------------------------------------------------------------------------------------------------------------------
echo.
goto menu
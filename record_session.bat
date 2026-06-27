@echo off
REM ============================================================
REM  Phase 0.5 - record a COMBAT/EXPLORATION replay session
REM  Run in your OWN terminal so you can play the game window.
REM
REM  Goal of THIS recording: exercise the subsystems the audit
REM  flagged but the basic-movement run never touched --
REM    - monster AI / hordes  (fight something)
REM    - RNG combat rolls      (melee or ranged attacks)
REM    - mapgen / exploration  (walk into unseen tiles, enter a building)
REM  This is the run most likely to expose real non-determinism,
REM  if any exists.
REM
REM  IMPORTANT for a replayable recording:
REM    - Load the EXISTING character (no new-character creation:
REM      its conditional popups desync replay).
REM    - Fight a monster, walk into unexplored area / a building,
REM      pick up / use items. Variety is the point here.
REM    - Then SAVE AND QUIT from the Esc menu. (The auto-quit
REM      safety net will also catch it if the log ends mid-action.)
REM
REM  Output: combat.replay   World: TestWorld (existing char)
REM ============================================================
setlocal
cd /d "%~dp0"

set BIN=cataclysm-tiles.exe
set REPLAY=combat.replay
set USERDIR=replay_userdir/
set WORLD=TestWorld
set SEED=replaytest

if not exist "%BIN%" (
    echo [ERROR] %BIN% not found. Build the TILES recorder first.
    exit /b 1
)

echo Recording to %REPLAY% (world=%WORLD%, seed=%SEED%) ...
echo   1) Continue your EXISTING character.
echo   2) FIGHT something, EXPLORE unseen tiles / a building, use items.
echo   3) Esc -^> Save and Quit.
echo.
"%BIN%" --replay-record "%REPLAY%" --userdir "%USERDIR%" --world "%WORLD%" --seed %SEED%

echo.
echo Done. Recorded -^> %REPLAY%
echo Next: python tools\replay_ab.py --bin .\cataclysm-headless.exe --replay %REPLAY% --userdir-template %USERDIR% --world %WORLD%
endlocal

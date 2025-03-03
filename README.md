# Skylords Updater

This simple script is an alternative updater for Skylords Reborn
that does not depend on the Linux unfriendly .Net framework.

## Installation

Put the script `skylords-upd.sh` into the BattleForge directory, next to
the `SkylordsRebornUpdater.exe`. The update process may change the file
`skylords-upd.sh` to an outdated version so an alternative filename is
recommended.

## Usage

Execute the script to update your game. Adjust the line
```
CHANNEL="live" # live or test or legacy
```
to your desired game channel. The default value `live` should be fine for most
players.

Then launch BattleForge manually through wine: `wine Battleforge.exe -online`.

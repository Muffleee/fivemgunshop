FiveM world control script.

-> Features <-

Ändere die Zeit mit /time <Stunden> <Minuten>
(Minuten können weggelassen werden)


Ändere das Wetter mit /weather <type>

Es gibt folgende Typen: 
    NEUTRAL 
    CLEAR
    EXTRASUNNY 
    OVERCAST 
    SMOG 
    FOGGY  
    CLOUDS 
    CLEARING
    RAIN
    THUNDER 
    SNOW
    SNOWLIGHT 
    BLIZZARD 
    XMAS
    HALLOWEEN
(können auch klein geschrieben werden)

Das Wetter sowie die Zeit werden für Clients, welche nach der
Ausführung des Commands joinen, aktualisiert. 


-> Installation/ Usage <-

1. Den "worldcontrol" Ordner in "resources" verschieben 
2.1 Automatisch beim Restart starten:
	-> "ensure worldcontrol" in die config.cfg
2.2 Selber starten:
	Folgende Befehle in die Konsole eingeben:
	-> "refresh"
	-> "start worldcontrol"
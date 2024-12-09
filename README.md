# Jalo's Simple Lemonbar
 a light, easy to use, understand, and edit lemonbar script.

Runs on 150mb with 0.5 avg CPU usage. 

 This is my personal use bar, so I only tested it on a 1920x1080p screen Arch Linux laptop with a single screen.

 There are certain things (such as current window focus) that break using 2 seperate screens, or different resolutions.

 If you want to use this bar, you will just have to kinda fiddle with the config file, but there should be no reason it shouldn't work with another resolution.

## Dependencies:
  
  -Pulse Audio

  -Xrandr

  -xrpop

  -xdotool

  -amixer

 ## How to install:
 install lemonbar (in whatever linux distro), and make a lemonbar folder in you .config folder.
 
 git clone the folder in the lemonbar folder you have just created. 

```bash
git clone https:/github.com/jaloaguero/lemonbar_dotfiles
```
 
 
 Add the following code to your startup file.
 
 
```bash
bash ~/.config/lemonbar/lemonbar_dotfiles/lemonbar_start.sh
```

## Configuration:

I included a configuration file, where you can change the standard config file, if you want to git clone somewhere else, or change the colors of the foreground or background.

Mess with the refresh rates of each at your own peril, as everything is updated on a 0.01 second tick, but things like the date, percentage, time are updated every 10, 5, 1 seconds. Could lead to unforseen circumstances.

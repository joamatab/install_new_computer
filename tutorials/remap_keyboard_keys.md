# Remap keyboard keys

https://gist.github.com/tanyuan/55bca522bf50363ae4573d4bdcf06e2e

- Send <kbd>Escape</kbd> if you tap <kbd>Caps Lock</kbd> alone.
- Send <kbd>Control</kbd> if you press <kbd>Caps Lock</kbd> with another key.

For both Vim and Emacs world.

## GNU/Linux

### Step 1. Install XCAPE

Install [XCAPE](https://github.com/alols/xcape) (`xcape`). (Linux utility to configure modifier keys to act as other keys when pressed and released on their own.)

Ubuntu:

```bash
sudo apt-get install xcape
```

### Step 2. Run the command

```bash
# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'
```

The effect should apply immediately.

### Step 3. Autostart

Append code from Step 2 to file `~/.xprofile` to run the command when X starts.

## macOS

1. Download and install [Karabiner-Elements](https://pqrs.org/osx/karabiner/), a powerful and stable keyboard customizer.
2. Open Karabiner-Elements, select **Complex Modifications** tab, and click **Add rule** at the bottom.
3. Find **Post escape if caps is pressed alone, left_ctrl otherwise** and click on **enable**.

The effect should apply immediately.

## Windows

### Option 1:

1. Download and install [AutoHotKey](https://autohotkey.com/).
2. Use the script [CapsLockCtrlEscape.ahk](https://gist.github.com/sedm0784/4443120).

### Option 2:

Download and run [dual-key-remap](https://github.com/ililim/dual-key-remap). (Note that in config.txt, CONTROL might needed to changed to LEFT_CTRL for some computers)

For both options, the effect should apply immediately.

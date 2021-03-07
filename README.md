# NoPWNed

**A dirty little addon to patch haveibeenpwned out of supervisor**

## What

After a recent update to Supervisor by the devs at hass, some of us have run into an issue where we're being nagged to change pwned passwords. As indicated by a couple of threads in the community we belive we should be able to turn this feature off at our own risk.

This addon does that, with a dirty hack that simply replaces the check with a stub

## Why

I don't know about your reasoning, but mine is simple, I have my hass instance tucked away on it's own vlan with all it's little iot toys. I don't care much if the credentials used in mqtt or camera access are pwned as long as the platform credentials are secure. So why waste the CPU cycles and bandwidth to test, and why nag me.

## Caution

This could potentially (but shouldn't) brick your supervisor, if you have the ssh & web terminal plugin installed and running you may be able to recover otherwise you will have to go to debug ssh which involves usb sticks and copying files. Do back up all you care about first please. I offer no warranties and no guarantees.

## How

On startup this addon simply checks to make sure the supervisor container exists, if it does it checks for a function call in the check's source code, if it exists it assumes the file is original, then copies the stub file into place, once that's done it restarts the supervisor. This takes a minute or two, don't panic, if you click on the "supervisor" tab in HA and you get an error, just wait a minute and try again.

## Installing & Using

1. Add this repository to your HASS
2. Install the NoPWNed addon
3. Disable protected mode, this will not work with protected mode on
4. Start the addon
5. Wait a couple of nervous minutes

At this point you can either leave the plugin in and have it start on boot to catch future updates, or not. I actually recommend not, just in case.

## See also

- https://community.home-assistant.io/t/opt-out-of-pwned-secrets-warnings/286394
- https://community.home-assistant.io/t/opt-out-in-password-check-to-third-party/287158
- https://community.home-assistant.io/t/block-ha-from-sending-out-passwords-to-third-party/286628

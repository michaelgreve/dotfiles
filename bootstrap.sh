#!/usr/bin/env bash

### Set computer name
computername="junior"
sudo scutil --set ComputerName "$computername"
sudo scutil --set HostName "$computername"
sudo scutil --set LocalHostName "$computername"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$computername"

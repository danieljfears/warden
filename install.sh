#!/bin/bash

feature=("add" "help" "list" "remove" "source" "uninstall")

for i in "${feature[@]}"
do
    echo $i
done

# -----------------------------------------------------------------
# EXIT OUT IF ALREADY INSTALLED
# -----------------------------------------------------------------

if [ -d /usr/local/bin/warden ]; then
  echo 'Warden is already installed. Please uninstall before attempting to reinstall.'
fi

# -----------------------------------------------------------------
# INSTALL WARDEN IF NOT INSTALLED
# -----------------------------------------------------------------

if [ ! -d /usr/local/bin/warden ]; then

  # -----------------------------------------------------------------
  # POPULATE ALIAS LIST FOR USER COMMANDS FROM ALIAS FILE
  # -----------------------------------------------------------------

  sh ./assets/alias.sh

  # touch /etc/profile.d/warden.sh # multi-user post-install support/later feature

  # -----------------------------------------------------------------
  # CONFIGURE GPG TO ALWAYS ASK FOR PASSWORD AND RESTART SERVICE
  # -----------------------------------------------------------------

  sudo mkdir ~/.gnupg && touch ~/.gnupg/gpg-agent.conf && chmod 755 ~/.gnupg/gpg-agent.conf
  
  sudo echo 'default-cache-ttl 0' >> ~/.gnupg/gpg-agent.conf
  sudo echo 'max-cache-ttl 0' >> ~/.gnupg/gpg-agent.conf

  pkill gpg-agent

  # -----------------------------------------------------------------
  # CREATE INSTALLATION FOLDER, MOVE SCRIPT FILES & SET PERMISSIONS
  # -----------------------------------------------------------------

  sudo mkdir -p /usr/local/bin/warden/
  sudo cp assets/*.sh /usr/local/bin/warden/
  sudo chmod 755 /usr/local/bin/warden/*.sh

  # -----------------------------------------------------------------
  # INSTALLATION MESSAGE & FILE CLEAN UP
  # -----------------------------------------------------------------

  tput setaf 4;
  echo '__        __            _'
  echo '\ \      / /_ _ _ __ __| | ___ _ __'
  echo ' \ \ /\ / / _` | __/  _  |/ _ \  _  \'
  echo '  \ V  V / (_| | | | (_| |  __/ | | |'
  echo '   \_/\_/ \__,_|_|  \__,_|\___|_| |_| for Azure'
  tput sgr0

  echo ''
  echo '***  Warden has been successfully installed  ***'
  echo ''
  echo '(Installation folder NOT deleted)'
  echo ''
  echo 'USAGE GUIDE'
  echo ''
  echo '- "warden source" loads credentials from an existing profile'
  echo '- "warden add" adds a new profle to store Azure credentials'
  echo '- "warden list" lists existing profiles'
  echo '- "warden remove" removes an existing profile'
  echo '- "warden help" displays the help menu'
  echo '- "warden uninstall" Uninstalls Warden and removes all profiles'
  echo ''

fi



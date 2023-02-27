#!/bin/sh

# Check if Python3, curl, wget, and tar are installed
if ! command -v python3 &> /dev/null || ! command -v curl &> /dev/null || ! command -v wget &> /dev/null || ! command -v tar &> /dev/null
then
    echo "Python3, curl, wget, or tar is not installed. Installing..."
    sudo apt-get install -y python3 curl wget tar
fi

# Clear the screen
clear

# Force home directory
path_home="$HOME/"

# What to backup
backup_quick=${path_home}".quicksilverd/config"
backup_ica=${path_home}".ica/config"
backup_sei=${path_home}".sei/config"
backup_stride=${path_home}".strided/config"
backup_sui=${path_home}".sui/sui_config"
backup_humans=${path_home}".humans/config"
backup_andromeda=${path_home}".andromedad/config"
backup_goa_ordos=${path_home}".ordos/config"
backup_quasar=${path_home}".quasarnode/config"
backup_nolus=${path_home}".nolus/config"
backup_arkhadian=${path_home}".arkh/config"

# Where to backup to
dest_dir="/mnt/backup"

# Check directory empty or not if empty create directory.
if [ ! -d "$dest_dir" ]
then
 echo "Creating directory..\ndone"
 mkdir "$dest_dir"
fi

# Create archive filename
day=$(date +%A-%T)
hostname=$(hostname -s)

# Banner
wget -qO- https://pastebin.com/raw/v7VX9GqH | sed -e 's/<[^>]*>//g'
echo "\n"

# Print options menu
echo "Choose folder to backup:"
echo "1. Backup folder quicksilverd"
echo "2. Backup folder kqcosmos"
echo "3. Backup folder sei"
echo "4. Backup folder stride"
echo "5. Backup folder sui"
echo "6. Backup folder humansai"
echo "7. Backup folder andromeda"
echo "8. Backup folder game of aliance ordos chain"
echo "9. Backup folder quasar"
echo "10. Backup folder nolus"
echo "11. Backup folder arkhadian"

echo "\n99. Create directory listing"

while true; do
  # Read user input
  read -p "Choose > " input

  # Check if the input is valid
  case $input in
    1) folder=$backup_quick; break;;
    2) folder=$backup_ica; break;;
    3) folder=$backup_sei; break;;
    4) folder=$backup_stride; break;;
    5) folder=$backup_sui; break;;
    6) folder=$backup_humans; break;;
    7) folder=$backup_andromeda; break;;
    8) folder=$backup_goa_ordos; break;;
    9) folder=$backup_quasar; break;;
    10) folder=$backup_nolus; break;;
    11) folder=$backup_arkhadian; break;;
    99)
       read -p "Port: " port
       echo "Running directory listing in http://$(hostname -I | awk '{print $1}'):$port"
       python3 -m http.server $port -d $dest_dir
       exit;;
    *) echo "Invalid choice! Try again.";;
  esac
done

# Get name when user input options menu
get_name=$(echo $folder | cut -d "/" -f 3)
final_name=$(echo $get_name | sed 's/\.//')

# Create archive filename
archive_file="$final_name-$hostname-$day.tgz"

# Backup the files using tar
tar czfP "$dest_dir/$archive_file" "$folder"

# Print start status message
echo "Backing up $folder to $dest_dir"

# Wait for a second
sleep 1

# Print end status message
echo "Backup finished! Check $dest_dir"

# Long listing of files in $dest to check file sizes.
ls -lh "$dest_dir"

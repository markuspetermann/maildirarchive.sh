#!/bin/bash

if [ "$#" -ne 1 ]
then
        echo "Usage: maildirarchive.sh <user>"
        exit
fi

user=$1


###########################
# Configuration           #
###########################

userdir="/srv/vmail/data/$user"
ardir="/srv/vmail/data/_shared/archiv/Maildir/.${user/./}"
enable_cleanup=1

###########################


if [ ! -d "$userdir/Maildir" ]
then
        echo -e "\e[31mUser $user does not exist"
        exit
fi

echo -e "\e[32mMoving mailbox for $user to archive"
echo -e "\e[34mSource: $userdir/Maildir"
echo -e "\e[34mDestination: $ardir"

mkdir "$ardir"


# move folders

for d in cur new tmp
do
        mv -i "$userdir/Maildir/$d" "$ardir/$d"
done

echo -e "\e[32mMoving Inbox"

cd "$userdir/Maildir"

for d in .??*
do
        if [[ "$d" =~ ^.(Junk|Junk-E-Mail|Trash|Gel&APY-schte\ Elemente)$ ]] || [ -z "$(find "$d"/{cur,new,tmp} -type f)" ]
        then
                echo -e "\e[31mSkipping $d"
                continue
        fi

        newd=$(sed -e 's/^\.INBOX\././' <<< $d)
        mv -i "$d" "$ardir$newd"
        echo -e "\e[32mMoving $d to $newd"
done


# set permissions

echo -e "\e[34mSetting permissions"
find $ardir* -exec chown vmail:vmail {} \;
find $ardir* -type d -exec chmod 700 {} \;
find $ardir* -type f -exec chmod 600 {} \;


# cleanup

if [ $enable_cleanup -eq 1 ]
then
        echo -e "\e[34mRemoving old directory"
        rm -r $userdir
fi
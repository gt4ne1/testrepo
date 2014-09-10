#!/bin/bash
#
# This script syncs Maildir directories between mail.alptec.net and membermail01.interush.net
#
# This script is called from membermail01.interush.net as root as runs as rsync as mailsync@membermail01.interush.net
#
#
# Requirements:
# 
#	1. mail.alptec.net:/home/vpopmail/domains/[domain]/ and all subdirectories need to have 750 permissions
#		since mailsync@mail.alptec.net is in vchkpw group.  "find /home/vpopmail/domains/[domain] -type d -exec chmod 750 {} + \;
#	2. 
# 
# mail.alptec.net virtual mail directories, ownership and permissions
#
# Created mailsync user in vchkpw group
#
# /home/vpopmail/domains/ - vpopmail:vchkpw 750
#					/alptec.net/ - vpopmail:vchkpw 700 - Untouched
#						/vpasswd vpopmail:vchkpw 644
#						/vpasswd.cdb vpopmail:vchkpw 600
#						/rush/ - vpopmail:vchkpw 700
#							/Maildir - vpopmail:vchkpw 700
#								/new/ - vpopmail:vchkpw 700
#									/mailmessage - vpopmail:vchkpw 600
#
# /data/mail/vmail/ - mail:mail 755
#				/membermail01.interush.net/ - mail:mail 700
#					/mattkrause/ - mail:mail 700
#						/cur/ - mail:mail 770
#							/mailmessage - mail:mail 600
#
#
#
#
#
#
# To Do:
#	*Rsync wild cards so don't have to sync per user
#   
#
#
#
#
#
#
#

# Change ownership of user's mailbox to mail:mailsync
chown -R mail:mailsync /data/mail/vmail/myspeedwayracer.com/

# Change permissions of mailbox directories to 770
find /data/mail/vmail -type d -exec chmod 770 {} +

# Run rsync as mailsync user excluding files/directories starting with: dovecot and lastauth.  membermail01 uses different directory structure than
#		mail.alptec.net 
su -c "rsync -avP --delete --exclude=dovecot* --exclude=lastauth mailsync@mail.alptec.net:/home/vpopmail/domains/myspeedwayracer.com/mattkrause/Maildir/.[^.]* /data/mail/vmail/myspeedwayracer.com/mattkrause/" mailsync

# Rsync'd files will be owned by mailsync:mailsync.  Need to change ownership to mail:mail
chown -R mail:mail /data/mail/vmail/

# Rsync'd files will be chmod 760. Need to chmod of directories to 700 and mailmessage files to 600.  For some reason the \; isn't needed here.
find /data/mail/vmail -type d -exec chmod 700 {} +
find /data/mail/vmail -type f -name \*mail.alptec.net\* -exec chmod 600 {} +



#!/bin/bash

su -c "rsync -avP --delete --exclude=dovecot* --exclude=lastauth mailsync@mail.alptec.net:/home/vpopmail/domains/myspeedwayracer.com/mattkrause/Maildir/* /data/mail/vmail/myspeedwayracer.com/mattkrause/" mailsync

chown -R mail:mail /data/mail/vmail/myspeedwayracer.com/mattkrause/

# Removed extra crap


#!/usr/bin/expect

spawn ssh-add /home/telmar/.ssh/id_ed25519
expect "Enter passphrase for /home/telmar/.ssh/id_ed25519: "
send "\r" # \r for return, put password before without space
expect eof

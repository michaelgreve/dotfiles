#!/usr/bin/env bash

declare -a sshkeys=('polbitbucket' 'mggithub');

SSH_DIR=$HOME/.ssh

if which scutil &> /dev/null; then
	HOSTNAME=`scutil --get LocalHostName`;
else
	HOSTNAME=`hostname -s`
fi

for key in ${sshkeys[@]}; do
	if ! [ -r $SSH_DIR/$key ]; then
		echo "Generating ${key}";
		ssh-keygen -t rsa -b 4096 -C "${key}@${HOSTNAME}" -f "${SSH_DIR}/${key}"
	fi;
done

echo
echo "Remember to add the keys to github, bitbucket, etc."
echo "and update your ${SSH_DIR}/config file.";
#!/bin/bash
set -e

# if [[ "$*" == npm*start* ]]; then
	for dir in "$WP_SOURCE/wp-content"/*/; do
		targetDir="$WP_CONTENT/$(basename "$dir")"
		mkdir -p "$targetDir"
		if [ -z "$(ls -A "$targetDir")" ]; then
			tar -c --one-file-system -C "$dir" . | tar xC "$targetDir"
		fi
	done

	if [ ! -e "$WP_CONTENT/wp-config.php" ]; then
    cp "$WP_SOURCE/wp-config-sample.php" "$WP_CONTENT/wp-config.php"
	fi

	ln -sf "$WP_CONTENT/wp-config.php" "$WP_SOURCE/wp-config.php"

	chown -R user "$WP_CONTENT"

	set -- gosu user "$@"
# fi

# exec "$@"
source /etc/apache2/envvars
apache2 -D FOREGROUND

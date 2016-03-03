#!/bin/bash
set -e

# if [[ "$*" == npm*start* ]]; then
	# for dir in "$WP_SOURCE/wp-content"/*/; do
	# 	targetDir="$VOLUME/$(basename "$dir")"
	# 	mkdir -p "$targetDir"
	# 	if [ -z "$(ls -A "$targetDir")" ]; then
	# 		tar -c --one-file-system -C "$dir" . | tar xC "$targetDir"
	# 	fi
	# done

	if [ ! -e "$VOLUME/wp-config.php" ]; then
    cp "$WP_SOURCE/wp-config-sample.php" "$VOLUME/wp-config.php"
    mv /var/www/wp-content /var/www/volume
    sed -i '20a define( "WP_CONTENT_DIR", dirname(__FILE__)."/volume/wp-content" );' "$VOLUME/wp-config.php"
  else
  	ln -sf "$VOLUME/wp-config.php" "$WP_SOURCE/wp-config.php"
	fi
	set -- gosu user "$@"
# fi

# exec "$@"
source /etc/apache2/envvars
apache2 -D FOREGROUND

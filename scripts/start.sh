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
    sed -i '86a define("WP_CONTENT_FOLDERNAME", "volume/wp-content");' "$VOLUME/wp-config.php"
		sed -i '87a define("WP_CONTENT_DIR", ABSPATH.WP_CONTENT_FOLDERNAME);' "$VOLUME/wp-config.php"
		sed -i '88a define("WP_SITEURL", "http://" . $_SERVER["HTTP_HOST"] . "/");' "$VOLUME/wp-config.php"
		sed -i '89a define("WP_CONTENT_URL", WP_SITEURL . WP_CONTENT_FOLDERNAME);' "$VOLUME/wp-config.php"	
	fi

	ln -sf "$VOLUME/wp-config.php" "$WP_SOURCE/wp-config.php"

	set -- gosu user "$@"
# fi

# exec "$@"
source /etc/apache2/envvars
apache2 -D FOREGROUND

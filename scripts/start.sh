#!/bin/bash
set -e

# if [[ "$*" == npm*start* ]]; then
	# for dir in "$WP_SOURCE/wp-content"/*/; do
	# 	targetDir="$VALUME/$(basename "$dir")"
	# 	mkdir -p "$targetDir"
	# 	if [ -z "$(ls -A "$targetDir")" ]; then
	# 		tar -c --one-file-system -C "$dir" . | tar xC "$targetDir"
	# 	fi
	# done

	if [ ! -e "$VALUME/wp-config.php" ]; then
    cp "$WP_SOURCE/wp-config-sample.php" "$VALUME/wp-config.php"
    mkdir "$VALUME/wp-content"
    mv "$WP_SOURCE/wp-content/*" "$WP_CONTENT"
    sed -i '20a define( "VALUME_DIR", dirname(__FILE__)."/valume/wp-content" );' "$VALUME/wp-config.php"
  fi

  ln -sf "$VALUME/wp-config.php" "$WP_SOURCE/wp-config.php"
	set -- gosu user "$@"
# fi

# exec "$@"
source /etc/apache2/envvars
apache2 -D FOREGROUND

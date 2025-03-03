#!/bin/sh -e

cd "$(dirname "$0")"

missing_deps=""
for dep in tr wc sed curl md5sum; do
	if ! which $dep > /dev/null; then
		missing_deps="$missing_deps $dep"
	fi
done
if [ x"$missing_deps" != x"" ]; then
	echo "The following dependencies of this script are missing: $missing_deps"
	exit 1
fi

WEBSITE_URL="http://download.skylords.eu/"

# returns list of all files, one per line with "update/" prefix, followed by ; and md5 sum
echo "Fetching update list..."
update_txt="$(curl "$WEBSITE_URL/update.txt" | tr \\\\ /)"

# now download them one by one from website if md5 does not match
i=0
n="$(echo $update_txt | tr -cd ' ' | wc -c)"
n=$((n+1))
for x in $update_txt; do
	i=$((i+1))
	file="$(echo "$x" | sed -e 's/^update\///' -e 's/;.*$//')"
	new_md5="$(echo "$x" | sed -e 's/^.*;//')"

	local_md5="$(md5sum "$file" | sed -e 's/ .*$//')" 2>/dev/null ||:
	if [ x"$local_md5" != x"$new_md5" ]; then
		echo "[$i/$n] Fetching $file ..."
		curl --create-dirs -o "$file" "$WEBSITE_URL/update/$file"
	else
		echo "[$i/$n] $file is up to date."
	fi
done

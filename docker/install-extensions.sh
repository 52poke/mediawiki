#!/bin/sh
set -eu

# Compile pinned GitHub sources without PECL's package.xml validation.
download_source() {
	extension_name="$1"
	source_url="$2"
	source_sha256="$3"
	archive_path="/tmp/${extension_name}.tar.gz"
	source_path="/usr/src/php/ext/${extension_name}"

	curl --fail --silent --show-error --location --retry 3 --retry-all-errors \
		--output "$archive_path" "$source_url"
	printf '%s  %s\n' "$source_sha256" "$archive_path" | sha256sum --check -
	mkdir -p "$source_path"
	tar -xzf "$archive_path" --strip-components=1 -C "$source_path"
	rm "$archive_path"
}

docker-php-source extract

download_source redis \
	https://codeload.github.com/phpredis/phpredis/tar.gz/refs/tags/6.3.0 \
	cb8f81df1a275599e4f8ddcfec7e1f65ed1953e6f5673649149fd680ebff4cad
download_source xmlrpc \
	https://codeload.github.com/php/pecl-networking-xmlrpc/tar.gz/refs/tags/xmlrpc-1.0.0RC3 \
	57fb00bd579b097c122a21a4ce84ca735b245928c7da046752f50576bcdd8760
download_source wikidiff2 \
	https://codeload.github.com/wikimedia/mediawiki-php-wikidiff2/tar.gz/refs/tags/1.14.2 \
	4dce99c13b62116e45f3b3f89a0d715108df5bec33f98d9b0fed7f7fadfba2b9

# GitHub's Redis archive omits liblzf; link to Debian's library instead.
docker-php-ext-configure redis \
	--enable-redis-lzf --with-liblzf \
	--enable-redis-zstd --with-libzstd \
	--enable-redis-lz4 --with-liblz4
docker-php-ext-configure xmlrpc --with-xmlrpc
docker-php-ext-configure wikidiff2 --enable-wikidiff2
docker-php-ext-install -j"$(nproc)" redis xmlrpc wikidiff2
docker-php-source delete

php --ri redis
php --ri xmlrpc
php --ri wikidiff2

#!/bin/bash

HOME_URL="https://www.airspayce.com/mikem/bcm2835/index.html"
DOWNLOAD_URL_REGEX="http://www.airspayce.com/mikem/bcm2835/bcm2835-(([0-9]+)\.([0-9]+)?(\.([0-9]+))?).tar.gz"
DOWNLOAD_URL=$(curl -s "$HOME_URL" | grep -E "$DOWNLOAD_URL_REGEX" -oh | head -1)
BCM2835_VERSION=$(echo "$DOWNLOAD_URL" | grep -E "([0-9]+)\.([0-9]+)?(\.([0-9]+))?" -oh)
BCM2835_TAR="bcm2835-$BCM2835_VERSION.tar.gz"
BCM2835_DIR="bcm2835-$BCM2835_VERSION"

# Check that the DOWNLOAD_URL was wound
if [ -z "$DOWNLOAD_URL" ]; then
    echo "Could not scrape the download url from $HOME_URL"
    exit 1
else
    echo "Found download url, version $BCM2835_VERSION"
fi

# Create temp directory
temp_dir=$(mktemp -d)

# Download .tar.gz & extract in temp_dir
DOWNLOAD_FILE="$temp_dir/$BCM2835_TAR"
wget "$DOWNLOAD_URL" -O "$DOWNLOAD_FILE"
tar -xf "$DOWNLOAD_FILE" -C "$temp_dir"

# rsync files to current direcctory
EXIT_CODE=0
UPDATED=0
RSYNC_OUT=$(rsync -rci "$temp_dir/$BCM2835_DIR"/* .)

if [ $? -ne 0 ]; then
    echo "rsync: error"
    EXIT_CODE=1
elif [ -n "$RSYNC_OUT" ]; then
    UPDATED=1
fi

# Remove temp directory
rm -rf "$temp_dir"

# GitHub integration
if [[ ! -z "$CI" ]]; then
    echo "updated=$UPDATED" >> $GITHUB_OUTPUT
    echo "version=$BCM2835_VERSION" >> $GITHUB_OUTPUT
fi

exit $EXIT_CODE

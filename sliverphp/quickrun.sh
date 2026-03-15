#!/bin/bash

if [[ "$(uname)" != "Darwin" ]]; then
    echo "Please switch to a Mac to continue."
    exit 1
fi

echo "Welcome to SliverPHP Quick Run - Created by EmoticonYT"

echo "Checking for Homebrew..."

if command -v brew &> /dev/null; then
    echo "Homebrew is installed. Continuing..."
else
    echo "Homebrew is missing. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if xcode-select -p &> /dev/null; then
    echo "Xcode Command Line Tools are installed. Continuing..."
else
    echo "Xcode Command Line Tools are missing. Installing now..."
    xcode-select --install
fi

echo "Checking for libimobiledevice..."

if command -v ideviceinfo &> /dev/null; then
    echo "libimobiledevice is installed."
else
    echo "libimobiledevice is not installed. Installing now..."
fi

echo "Checking for PHP..."

if command -v php &> /dev/null; then
    echo "PHP is installed. Continuing..."
else
    echo "PHP is not installed. Installing now..."
    brew install php
fi


echo "Checks are complete."

cd /tmp

mkdir -p sliverphp

cd sliverphp

echo "Downloading SliverPHP..."
curl -LO "https://raw.githubusercontent.com/EmoticonYT/resources/refs/heads/main/sliverphp/sliver.php" 

killall php ideviceactivation &

PRODUCT_TYPE=$(ideviceinfo -k ProductType 2>/dev/null)
PRODUCT_VERSION=$(ideviceinfo -k ProductVersion 2>/dev/null)

if [ "$PRODUCT_TYPE" != "iPad2,1" ]; then
    if [ -z "$PRODUCT_VERSION" ] || [ "$(echo "$PRODUCT_VERSION >= 7.1" | bc)" -eq 1 ]; then
        echo "Error: Device ($PRODUCT_TYPE) on iOS $PRODUCT_VERSION is unsupported."
        exit 1
    fi
fi

php -S localhost:43523 -t . sliver.php &

pause 2

ideviceactivation activate --service http://localhost:43523

killall php ideviceactivation

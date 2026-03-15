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

curl -LO "https://raw.githubusercontent.com/EmoticonYT/resources/refs/heads/main/sliverphp/sliver.php"

php -S localhost:43523 -t . sliver.php &

wait 5

ideviceactivation activate --service http://localhost:43523


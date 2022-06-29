#!/bin/bash

set -e

NAME='aptos-cli'
CRATE_NAME='aptos'
CARGO_PATH="crates/$CRATE_NAME/Cargo.toml"
ARCH=`uname -m | tr [:upper:] [:lower:]`
OS=`uname -s | tr [:upper:] [:lower:]`
VERSION=`cat "$CARGO_PATH" | grep "^\w*version =" | sed 's/^.*=[ ]*"//g' | sed 's/".*$//g'`

echo "Building release $VERSION of $NAME for $OS-$ARCH"
cargo build -p $CRATE_NAME --profile cli

cd target/cli/

# Compress the CLI
ZIP_NAME="$NAME-$VERSION-$OS-$ARCH.zip"

echo "Zipping release: $ZIP_NAME"
zip $ZIP_NAME $CRATE_NAME
mv $ZIP_NAME ../..
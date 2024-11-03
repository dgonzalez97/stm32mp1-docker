#!/bin/bash

# Set up environment variables
export YOCTO_DIR=/home/developer/workdir/bytedevkit-stm32mp1/5.0

echo "Starting initial Yocto repo setup..."
echo "YOCTO_DIR is set to $YOCTO_DIR"

# Create the directory if it doesn't exist
mkdir -p $YOCTO_DIR

cd $YOCTO_DIR

# Initialize repo
echo "Initializing repo..."
repo init -b scarthgap -u https://github.com/bytesatwork/bsp-platform-st.git

# Sync repositories
echo "Syncing repositories (this may take a while)..."
repo sync

# Get current date and commit info
echo "Repo sync completed on $(date)"
echo "Latest commit info from each repository:"
repo forall -c 'echo "$REPO_PATH: $(git log -1 --pretty=format:"%h - %s (%ci)")"'

echo "Initial repo setup is complete -- Git errors are because of GitCommandError: 'var GIT_COMMITTER_IDENT. - TO_DO Investigate how to remove GIT Config check"

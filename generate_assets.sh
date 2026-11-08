#!/usr/bin/env bash
set -e

# Resolve repository root directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

CHECKSUM_FILE=".asset_checksum"
FORCE=0

for arg in "$@"; do
    if [ "$arg" = "--force" ]; then
        FORCE=1
    fi
done

# Compute a single aggregate SHA-1 hash across all raw source assets
compute_checksum() {
    (
        find source.txt LICENSE.TXT CREDITS.TXT encyclopedia.txt -type f 2>/dev/null
        find rooms -name '*.map' -type f 2>/dev/null
        find gfx -name '*.bmp' -type f 2>/dev/null
        find support -type f \( -name '*.cpp' -o -name '*.h' \) 2>/dev/null
    ) | sort | tr '\n' '\0' | xargs -0 sha1sum 2>/dev/null | sha1sum | awk '{print $1}'
}

# Verify whether all core generated targets exist and are non-empty
check_outputs_exist() {
    local required=(
        "glbdef.h"
        "glbdef.cpp"
        "credits.cpp"
        "license.cpp"
        "encyclopedia.cpp"
        "encyclopedia.h"
        "rooms/allrooms.cpp"
        "rooms/allrooms.h"
        "gfx/all_bitmaps.cpp"
    )
    for f in "${required[@]}"; do
        if [ ! -s "$f" ]; then
            return 1
        fi
    done
    return 0
}

CURRENT_HASH=$(compute_checksum)
STORED_HASH=""
if [ -f "$CHECKSUM_FILE" ]; then
    STORED_HASH=$(cat "$CHECKSUM_FILE" 2>/dev/null || true)
fi

# Determine whether generation needs to execute
NEEDS_REBUILD=0

if [ "$FORCE" -eq 1 ]; then
    echo "[POWDER Pre-Build] Force flag detected. Rebuilding all assets..."
    NEEDS_REBUILD=1
elif ! check_outputs_exist; then
    echo "[POWDER Pre-Build] Generated assets missing. Running initial asset build..."
    NEEDS_REBUILD=1
elif [ "$CURRENT_HASH" != "$STORED_HASH" ]; then
    echo "[POWDER Pre-Build] Asset source modification detected (hash mismatch). Regenerating..."
    NEEDS_REBUILD=1
fi

if [ "$NEEDS_REBUILD" -eq 0 ]; then
    echo "[POWDER Pre-Build] Assets are up to date (checksum: ${CURRENT_HASH:0:8}). Skipping."
    exit 0
fi

echo "========================================================"
echo " [POWDER] Compiling Support Tools & Generating Assets"
echo "========================================================"

echo "-> [1/5] Compiling 6 helper tools in support/..."
make -C support/bmp2c -s
make -C support/txt2c -s
make -C support/encyclopedia2c -s
make -C support/enummaker -s
make -C support/map2c -s
make -C support/tile2c -s

echo "-> [2/5] Normalizing text file line endings..."
sed -i 's/\r$//' source.txt encyclopedia.txt 2>/dev/null || true
sed -i 's/\r$//' rooms/*.map 2>/dev/null || true

echo "-> [3/5] Compiling rooms into allrooms.cpp..."
(cd rooms && ./buildrooms.bash)

echo "-> [4/5] Compiling tile arrays into all_bitmaps.cpp..."
(cd gfx && ./rebuild.sh)

echo "-> [5/5] Generating enums, encyclopedia, credits, and license..."
./support/enummaker/enummaker.exe source.txt
./support/txt2c/txt2c.exe LICENSE.TXT license.cpp
./support/txt2c/txt2c.exe CREDITS.TXT credits.cpp
./support/encyclopedia2c/encyclopedia2c.exe encyclopedia.txt

# Save the post-normalization hash to the checksum manifest
FINAL_HASH=$(compute_checksum)
echo "$FINAL_HASH" > "$CHECKSUM_FILE"

echo "========================================================"
echo " [POWDER] Asset generation finished (checksum: ${FINAL_HASH:0:8})!"
echo "========================================================"
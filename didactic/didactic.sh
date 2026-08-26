#!/usr/bin/env bash

DIST_DIR=dist
STATIC_DIR=static
CONTENT_DIR=content

TREE_FILE=tree

fetch_and_patch() {
    local fetch_url="$1"
    local target_file="$2"
    local patch_file="$3"

    mkdir -p "$(dirname "$target_file")"
    curl -sSL "$fetch_url" -o "$target_file"
    git apply "$patch_file"
}

find "$STATIC_DIR" -type f -name "*.scss" | while read -r scss_file; do
    if [[ $(basename "$scss_file") == _* ]]; then
        continue
    fi

    rel_path="${scss_file#"$STATIC_DIR"/}"
    css_file="$CONTENT_DIR/${rel_path%.scss}.css"
    target_dir=$(dirname "$css_file")

    mkdir -p "$target_dir"
    grass "$scss_file" "$css_file"
done

mkdir -p $DIST_DIR
rm -rf -- "${DIST_DIR:?}"/*
rm -f $TREE_FILE

fetch_and_patch "https://raw.githubusercontent.com/Akari202/vec-utils/refs/heads/main/docs/quaternions.typ" "$CONTENT_DIR/notes/quaternions.typ" "$STATIC_DIR/patches/quaternions.patch"

find "${CONTENT_DIR:?}" -type f ! -name "$CONTENT_DIR/index.typ" >$TREE_FILE

# typst watch --no-serve --features bundle,html --format bundle --root ./ --package-path packages --input compile-host=didactic didactic/didactic.typ $DIST_DIR
typst compile --features bundle,html --format bundle --root ./ --package-path packages --input compile-host=didactic didactic/didactic.typ $DIST_DIR

rm $TREE_FILE

tree -a -C -I '.git|.DS_Store|packages'

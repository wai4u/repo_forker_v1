#!/bin/bash

# repos.yamlファイルのパス
repos_file="repos.yaml"

# repos.yamlを読み込んで各リポジトリURLを抽出し、クローンする
grep '-' "$repos_file" | while read -r line; do
    repo_url=$(echo $line | cut -d' ' -f2)
    repo_name=$(basename "$repo_url" .git)
    user_name=$(basename $(dirname "$repo_url"))
    new_name="${user_name}-${repo_name}"

    # リポジトリが既に存在するか確認
    if gh repo view "algoplay/$new_name" > /dev/null 2>&1; then
        echo "Repository $new_name already exists, skipping..."
    else
        echo "Forking $repo_url into $new_name..."
        gh repo fork --org=algoplay --fork-name="$new_name" "$repo_url"
        sleep 1
    fi
done

echo "All repositories have been processed."

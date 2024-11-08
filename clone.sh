#!/bin/bash

# repos.yamlファイルのパス
repos_file="repos.yaml"

# repos.yamlを読み込んで各リポジトリURLを抽出し、クローンする
grep '-' "$repos_file" | while read -r line; do
    repo_url=$(echo $line | cut -d' ' -f2)
    repo_name=$(basename "$repo_url" .git)
    user_name=$(basename $(dirname "$repo_url"))
    new_name="${user_name}-${repo_name}"
    echo "Cloning $repo_url into $new_name..."
    gh repo clone "$repo_url" "$new_name"
done

echo "All repositories have been cloned."

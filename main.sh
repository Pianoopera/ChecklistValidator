#!/bin/bash

# Ensure GITHUB_TOKEN is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "GITHUB_TOKEN is not set. Exiting."
  exit 1
fi

PR_URL=$1

# Ensure PR_URL is set
if [ -z "$PR_URL" ]; then
  echo "Pull request URL is not provided. Exiting."
  exit 1
fi

# PR_URLの形式を検証
if ! [[ $PR_URL =~ ^https://(github\.com/[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+/pull/[0-9]+|api.github.com/repos/[a-zA-Z0-9_-]+/[a-zA-Z0-9_-]+/pulls/[0-9]+)$ ]]; then
  echo "Pull request URL is invalid. Exiting."
  exit 1
fi

# プルリクエストの内容を取得
PR_BODY=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$PR_URL" | jq -r '.body')

# チェックリストの未チェック項目をカウント
UNCHECKED_COUNT=$(echo "$PR_BODY" | grep -o "\- \[ \]" | wc -l)

# 結果を出力
if [ "$UNCHECKED_COUNT" -eq 0 ]; then
  echo "All checklist items are checked."
  exit 0
else
  echo "There are $UNCHECKED_COUNT unchecked checklist items."
  exit 1
fi
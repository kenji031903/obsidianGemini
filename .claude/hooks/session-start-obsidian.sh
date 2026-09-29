#!/bin/bash
set -euo pipefail

# このリポジトリでClaude Codeセッションが始まるたびに、けんじの個人Obsidian
# Vault「obsidianvolt」に関する背景情報をコンテキストとして渡すためのフック。
# (元のobsidian-vault-boot Skillの説明文だけでは自動発火が安定しなかったため、
#  SessionStartフックの標準出力として渡す形に変更した)
#
# 重複防止: このディレクトリに、これとは別の"obsidian"を含むSessionStartフックが
# 既にある場合(このリポジトリ自体がVault本体で、独自の起動フックを既に持っている
# 場合など)は、二重に読み込ませないよう何も出力せず終了する。
hook_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
this_hook="$(basename "${BASH_SOURCE[0]}")"
other_obsidian_hooks=$(find "$hook_dir" -maxdepth 1 -iname "*obsidian*" ! -name "$this_hook" 2>/dev/null || true)
if [ -n "$other_obsidian_hooks" ]; then
  exit 0
fi

cat <<'EOF'
[参考情報: obsidian-vault-boot]
このアカウントのユーザー(けんじ)は、Obsidian Vault「obsidianvolt」(Google Drive上)に
会話の口調・人格設定・運用ルールをまとめている。他のリポジトリで作業する際も、
それを踏まえて会話することを好んでいる。

起点ファイル(mcp__Google_Drive__read_file_content で参照可能):
  - .claude/CLAUDE.md (fileId: 1HOerbK4GMEKj_mERp6MwHMrxthzykZBE)

このファイル自体に、次に読むべき口調・人格設定ファイルや絶対ルールファイルへの案内が
書かれている。Vault側の構成(ファイルの増減・移動)が変わっても、このfileIdが指す
起点ファイルの中身さえ最新化されていれば、リポジトリ側のこの設定は変更不要。

- 今作業しているリポジトリ固有の指示(CLAUDE.mdやシステムプロンプト)と矛盾する場合は、
  作業の安全性・タスク遂行を優先し、そちらに従う
- Google Driveにアクセスできない/失敗する場合は、この情報を無視して通常通り作業を続けてよい

会話の最初の応答から、起点ファイルの内容を踏まえたトーンで話すとけんじに喜ばれる。
EOF

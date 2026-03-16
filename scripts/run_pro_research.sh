#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  run_pro_research.sh login
  run_pro_research.sh preview "<task>" <paths...>
  run_pro_research.sh run "<task>" <paths...>

Pass files, directories, or quoted globs as <paths...>. Use exclude globs by
prefixing them with !, for example "!**/*.snap".
EOF
}

die() {
  echo "Error: $*" >&2
  exit 1
}

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

script_dir() {
  cd "$(dirname "${BASH_SOURCE[0]}")" && pwd
}

skill_root() {
  cd "$(script_dir)/.." && pwd
}

profile_dir() {
  printf '%s\n' "$HOME/.oracle/browser-profile"
}

make_slug() {
  local prompt="$1"
  local slug

  slug=$(
    printf '%s' "$prompt" |
      tr '[:upper:]' '[:lower:]' |
      LC_ALL=C tr -cs 'a-z0-9' '\n' |
      sed '/^$/d' |
      head -n 5 |
      paste -sd '-' -
  )

  if [ -z "$slug" ]; then
    slug="pro-research-$(date '+%Y%m%d-%H%M%S')"
  fi

  printf '%s\n' "$slug"
}

is_sensitive_path() {
  case "$1" in
    *.env|*.env.*|*/.env|*/.env.*|*.pem|*.key|*.p12|*.pfx|*id_rsa*|*id_ed25519*|*service-account*|*credentials*|*secret*|*token*|*auth.json)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_binary_heavy_path() {
  case "$1" in
    *.pdf|*.png|*.jpg|*.jpeg|*.gif|*.webp|*.bmp|*.ico|*.zip|*.tar|*.gz|*.tgz|*.7z|*.dmg|*.mp3|*.mp4|*.mov|*.avi|*.wav|*.docx|*.pptx|*.xlsx|*.xls|*.numbers|*.pages|*.keynote)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

login_bootstrap() {
  local root
  root="$(skill_root)"
  local login_probe="$root/references/problem-framing.md"
  local profile
  profile="$(profile_dir)"

  [ -f "$login_probe" ] || die "Missing login probe file: $login_probe"
  mkdir -p "$profile"

  echo "Starting Pro Research login bootstrap. Sign into ChatGPT in the opened browser if prompted." >&2
  echo "Reusing persistent browser profile: $profile" >&2

  ORACLE_BROWSER_PROFILE_DIR="$profile" \
  npx -y @steipete/oracle \
    --engine browser \
    --browser-manual-login \
    --browser-port 9333 \
    --browser-keep-browser \
    --browser-input-timeout 120000 \
    --browser-timeout 5m \
    --prompt "Return exactly: login bootstrap ok." \
    --file "$login_probe"
}

main() {
  if [ "$#" -lt 1 ]; then
    usage >&2
    exit 1
  fi

  require_cmd npx

  local mode="$1"
  shift

  case "$mode" in
    login)
      if [ "$#" -ne 0 ]; then
        usage >&2
        die "login takes no additional arguments"
      fi
      login_bootstrap
      return
      ;;
    preview|run)
      ;;
    *)
      usage >&2
      die "Mode must be login, preview, or run"
      ;;
  esac

  if [ "$#" -lt 2 ]; then
    usage >&2
    exit 1
  fi

  local prompt="$1"
  shift

  local -a files=()
  local path
  for path in "$@"; do
    if [[ "$path" == \!* ]]; then
      files+=("$path")
      continue
    fi

    if is_sensitive_path "$path"; then
      die "Refusing sensitive-looking path: $path"
    fi

    if is_binary_heavy_path "$path"; then
      die "Refusing binary-heavy path: $path. Convert it to text first, then rerun."
    fi

    files+=("$path")
  done

  if [ "${#files[@]}" -eq 0 ]; then
    die "Provide at least one file, directory, or glob"
  fi

  local slug
  slug="$(make_slug "$prompt")"
  local profile
  profile="$(profile_dir)"
  mkdir -p "$profile"

  local -a cmd=(npx -y @steipete/oracle --prompt "$prompt" --slug "$slug")
  for path in "${files[@]}"; do
    cmd+=(--file "$path")
  done

  case "$mode" in
    preview)
      cmd=(npx -y @steipete/oracle --dry-run summary --files-report --prompt "$prompt" --slug "$slug")
      for path in "${files[@]}"; do
        cmd+=(--file "$path")
      done
      echo "Previewing Pro Research bundle with slug: $slug" >&2
      ;;
    run)
      cmd=(
        env
        "ORACLE_BROWSER_PROFILE_DIR=$profile"
        npx -y @steipete/oracle
        --engine browser
        --browser-manual-login
        --browser-port 9333
        --browser-reuse-wait 10s
        --browser-profile-lock-timeout 300s
        --browser-auto-reattach-delay 5s
        --browser-auto-reattach-interval 3s
        --browser-auto-reattach-timeout 60s
        --model gpt-5.4-pro
        --prompt "$prompt"
        --slug "$slug"
      )
      for path in "${files[@]}"; do
        cmd+=(--file "$path")
      done
      echo "Starting Pro Research browser run with slug: $slug" >&2
      ;;
  esac

  "${cmd[@]}"
}

main "$@"

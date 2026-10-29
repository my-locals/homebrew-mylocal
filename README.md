# homebrew-mylocal

MyLocal Homebrew Tap: the MyLocal macOS menu bar app and the `mylocal` command line tool.
MyLocal finds dev servers (node, java, Docker containers, …) left listening after work hours and cleans them up, with a warning first.
This repository also hosts the release files (GitHub Releases).

## Setup

```bash
brew tap my-locals/mylocal
brew trust --tap my-locals/mylocal
```

## Install

```bash
brew install --cask mylocal
```

This installs the macOS app and links the `mylocal` command line tool that comes inside the app; they always have the same version.
Apple silicon and macOS 13 (Ventura) or later only.
Without Homebrew, download [`MyLocal.dmg`](https://github.com/my-locals/homebrew-mylocal/releases/latest/download/MyLocal.dmg) from the latest release.
Every file is signed with a Developer ID and notarized by Apple.

Open MyLocal once and allow it to run in the background; the cleanup daemon runs as your user, no administrator password.

## Upgrade

The app updates itself (General > Updates). Homebrew leaves it to the app, so `brew upgrade` skips it; to have Homebrew upgrade it anyway:

```bash
brew upgrade --cask --greedy mylocal
```

## Uninstall

```bash
brew uninstall --cask mylocal         # the app, the CLI link and the background daemon
brew uninstall --cask --zap mylocal   # also settings, activity log, logs and caches
```

If you deleted MyLocal.app yourself first, add `--force`.

## Troubleshooting

If you see a message that the tap is not trusted, trust it again:

```bash
brew trust --tap my-locals/mylocal
```

## AI agents

The [`mylocal-plugin`](https://github.com/my-locals/mylocal-plugin) skill lets Claude Code, Codex CLI and Antigravity CLI read MyLocal's activity log and diagnostics and change its schedule and rules with `mylocal`.

## 한국어

```bash
# 처음 한 번
brew tap my-locals/mylocal
brew trust --tap my-locals/mylocal

# 설치 (앱과 명령줄 도구 mylocal)
brew install --cask mylocal

# 업그레이드: 앱이 스스로 업데이트하므로 보통은 필요 없다
brew upgrade --cask --greedy mylocal

# 제거 (--zap은 설정·활동 로그까지)
brew uninstall --cask mylocal
```

"untrusted tap" 메시지가 나오면 `brew trust --tap my-locals/mylocal`를 실행합니다.
앱과 앱 안에 든 `mylocal` 명령줄 도구가 함께 설치되고 버전도 늘 같습니다. Apple silicon, macOS 13 이상만 지원합니다.
처음 한 번 MyLocal을 열고 백그라운드 실행을 허용하면 정리 데몬이 사용자 권한으로 돕니다. 관리자 암호는 필요 없습니다.

## Releases

| Tag | Files | Cask |
|---|---|---|
| `app-v<version>` | `MyLocal.dmg`: the macOS app (arm64) with the daemon and the `mylocal` CLI inside. `MyLocal.app.tar.gz`, `MyLocal.app.tar.gz.sig`, `latest.json`: the app's own update feed | `mylocal` |

The latest app release is always marked as "Latest", so
`https://github.com/my-locals/homebrew-mylocal/releases/latest/download/MyLocal.dmg` always points to the newest app,
and the app checks `…/releases/latest/download/latest.json` for updates.
Publishing a release runs `.github/workflows/update-casks.yml`, which updates `version` and `sha256` of the cask.

# homebrew-tap

Homebrew tap for [Agent World](https://github.com/hodkep/agent-world), a pixel-art office for running Claude Code and Antigravity agents. macOS only.

```
brew install --cask hodkep/tap/agent-world
```

or in two steps: `brew tap hodkep/tap`, then `brew install --cask agent-world`.

The app is not signed with an Apple Developer ID yet. So that it opens without macOS's "Open Anyway" step, the cask removes the quarantine mark macOS puts on downloaded apps from Agent World.app. That skips macOS's first-launch check for this app only, and the cask says so when it installs. If you want that check, download the dmg from the [release page](https://github.com/hodkep/agent-world/releases/latest) instead.

**Updating.** Agent World tells you about a new version and can install it from inside the app. To update through Homebrew instead: `brew upgrade --cask --greedy agent-world` (`--greedy` is needed because the app updates itself).

**Removing.** `brew uninstall --cask agent-world`. Your agents, worktrees and settings live in `~/.agent-world` and are not touched.

## How the cask stays current

`.github/workflows/update-cask.yml` reads the latest release of `hodkep/agent-world`, and when its version differs from the cask it rewrites the version and the two sha256 values (GitHub publishes each file's sha256 with the release), checks the result with `brew style` and `brew audit --cask --online`, and commits it. It runs:

- the moment a release is published, signalled by `notify-tap.yml` in the Agent World repository;
- every 6 hours, as a safety net if that signal is ever missed;
- by hand: Actions, update-cask, Run workflow.

The signal is only a wake-up call. The workflow never trusts what it carries: it always reads the release itself.

Licensed under the [Apache License 2.0](LICENSE).

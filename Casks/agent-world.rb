cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.9.0"
  sha256 arm:   "cf0f5528c86346f969e3d0215bf28145e31d26a255a8f05ec687908930db542c",
         intel: "a1df87323b0a9126dec046750ffacbc57f041e9b4b53c760fe80459ae2daa05a"

  # The project's mirror (Cloudflare R2), which is faster than GitHub's release downloads; it keeps the newest stable, the version named here.
  url "https://pub-761b6780fbbc4b30b60a22f902c0e743.r2.dev/v#{version}/Agent-World-#{version}-#{arch}.dmg"
  name "Agent World"
  desc "Run and steer coding agents as characters in a pixel-art office"
  homepage "https://github.com/hodkep/agent-world"

  livecheck do
    url "https://github.com/hodkep/agent-world"
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Agent World.app"

  # The app is not signed with an Apple Developer ID yet, so macOS would block its first launch.
  # Homebrew marks downloaded apps as quarantined; this removes that mark from this one app.
  # The caveats below say so.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Agent World.app"]
  end

  caveats <<~EOS
    Agent World is not signed with an Apple Developer ID yet. So that it opens without macOS's
    "Open Anyway" step, this cask removes the quarantine mark macOS puts on downloaded apps from
    Agent World.app. That skips macOS's first-launch check for this app only. Install the dmg from
    the release page instead if you want that check:
      https://github.com/hodkep/agent-world/releases/latest
  EOS
end


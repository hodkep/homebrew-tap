cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.11.0"
  sha256 arm:   "da8ed7f93bc6846a3f245402f801902be1c9971514579490150ee6baa8be9ad3",
         intel: "198eae82a8c295612941bce1a91186ab4c24a7c3663ec5198993ff9efe00323b"

  # The project's mirror (Cloudflare R2), which is faster than GitHub's release downloads; it keeps the newest stable, the version named here.
  url "https://dl.agent-world.in/v#{version}/Agent-World-#{version}-#{arch}.dmg"
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


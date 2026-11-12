cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.13.3"
  sha256 arm:   "4196a8300f176a52084572ff3ab88a70d15632a29f4a419bd54a741be0e3dd0d",
         intel: "c4c28b2fe4cf734938e076713ce39d2572113f8d5ba40a12dfa63d568ab7ed99"

  # The project's mirror (Cloudflare R2), faster than GitHub's downloads; it keeps the newest stable.
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

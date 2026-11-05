cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.11.3"
  sha256 arm:   "09dcfbcc95a3fa35c22101f2ef7108ee8d807b6bb74b0b284864fa3d1e50cd3f",
         intel: "437bcbd545c31c55bd2a29718e46d746ff3c411a71db58f8f3784c1d2dc6a47a"

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

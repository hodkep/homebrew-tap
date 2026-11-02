cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.10.0"
  sha256 arm:   "05c8c34e7113cbd199dbfec920bd90e397876dbc0573bff96f20fb65ec4d1619",
         intel: "31c1a855af8a688ca417994af88433e391986f4163a0e39bb9b8a13826b4dd7a"

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


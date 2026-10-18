cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.1.1"
  sha256 arm:   "c452ce69d49ff259e57dcb8adc144911923f71481c5b97398ec6ab7cc8910604",
         intel: "e1f048242d04118f75a5b84480ae8e822aa16d337839fbc5a07c10816b153f0e"

  url "https://github.com/hodkep/agent-world/releases/download/v#{version}/Agent-World-#{version}-#{arch}.dmg"
  name "Agent World"
  desc "Run and steer coding agents as characters in a pixel-art office"
  homepage "https://github.com/hodkep/agent-world"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Agent World.app"

  caveats <<~EOS
    Agent World is not signed with an Apple Developer ID yet, so macOS blocks the first launch.
    On macOS 15 and later: open it once, then go to System Settings > Privacy & Security and
    choose "Open Anyway". The README has the details:
      https://github.com/hodkep/agent-world#quick-start
  EOS
end

cask "agent-world" do
  arch arm: "arm64", intel: "x64"

  version "0.1.2"
  sha256 arm:   "232504e3e2d750d318c75f0963786380b06dbb102e3748c098a0f12ee702b04a",
         intel: "a00e688c5e513215ada45113fc67c779781020025df5e69467311f0ecdbf4f25"

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

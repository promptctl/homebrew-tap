# The body of the Homebrew cask in promptctl/homebrew-tap, Casks/low-talker.rb. Its version
# and sha256 are the two @-words scripts/update-cask fills in from a release; the tap's copy
# is that file's output, so a change to the cask is made here.
cask "low-talker" do
  version "0.1.0-alpha.9"
  sha256 "09b7e1af8e353127506d9d60906445a73621605b4d2a6a059062be8e64527d53"

  # The offline package: the network one replaces it, and only one may be installed.
  url "https://github.com/promptctl/low-talker/releases/download/v#{version}/LowTalker-offline.pkg"
  name "LowTalker"
  desc "Push-to-talk dictation that runs entirely on your Mac"
  homepage "https://github.com/promptctl/low-talker"

  # Every release so far is a pre-release, which :github_latest never offers.
  livecheck do
    url "https://github.com/promptctl/low-talker/releases"
    regex(/^v?(\d+(?:\.\d+)+(?:-[\w.]+)?)$/i)
    strategy :github_releases
  end

  depends_on macos: ">= :sequoia"

  pkg "LowTalker-offline.pkg"

  # The package writes the app and its input method as plain files, so the receipt, which
  # lists both, is what forgets them; the two are deleted here as well for a Mac whose
  # receipt is gone.
  uninstall quit:    [
              "ai.promptctl.low-talker",
              "ai.promptctl.low-talker.inputmethod.dictation",
            ],
            pkgutil: "ai.promptctl.low-talker",
            delete:  [
              "/Applications/LowTalker.app",
              "/Library/Input Methods/LowTalker Input Method.app",
            ]

  zap trash: "~/Library/Containers/ai.promptctl.low-talker"

  caveats <<~EOS
    Open LowTalker. It asks for microphone access and for its input method to be switched on,
    and then prepares the model, which takes a few minutes the first time.
  EOS
end

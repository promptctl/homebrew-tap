cask "vhid" do
  version "0.1.0"
  sha256 "4e82703425cfe5f47950177ec80682448aab2617b1bc1644a80dca1f629d01e2"

  url "https://github.com/promptctl/vhid/releases/download/v#{version}/vhid-#{version}.pkg"
  name "vhid"
  desc "Virtual keyboard and mouse driven from a CLI or over MCP"
  homepage "https://github.com/promptctl/vhid"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  pkg "vhid-#{version}.pkg"

  # vhid-uninstall is the one list of what the pkg installed; it stops the daemon and the
  # menu bar item, removes their files and forgets the receipt. It leaves the pqrs driver,
  # which Karabiner-Elements may share.
  uninstall script: {
    executable: "/usr/local/libexec/vhid-uninstall",
    sudo:       true,
  }

  caveats <<~EOS
    macOS lets only the person at the Mac approve a driver. Turn on
    org.pqrs.Karabiner-DriverKit-VirtualHIDDevice under
      System Settings > General > Login Items & Extensions > Driver Extensions (i)
    then run `vhid doctor`; it prints `ready` once vhid can type and click.
  EOS
end

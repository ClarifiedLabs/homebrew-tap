cask "cengine" do
  version "0.0.53"
  sha256 "eaab0ee264c03646ac42345d343f1a0cfc5eee004118c78d8ca06e6a94ea2e77"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.53/cengine-0.0.53.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using one raw Linux VM per container"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on formula: "docker"

  pkg "cengine-0.0.53.pkg"

  postflight do
    system_command "/usr/bin/open",
                   args: ["/Applications/cengine.app", "--args", "--opened-by-installer"],
                   must_succeed: false
  end

  uninstall early_script: {
              executable: "/bin/sh",
              args: [
                "-c",
                'if [ -x "$1" ]; then "$1" --uninstall-support; fi',
                "--",
                "/Applications/cengine.app/Contents/MacOS/cengine",
              ],
              # Teardown is best effort. Homebrew's launchctl/delete stanzas
              # must still remove cengine if stale VM ownership is ambiguous.
              must_succeed: false,
            },
            launchctl: ["dev.cengine.engine", "dev.cengine.network-helper"],
            quit: "dev.cengine.app",
            pkgutil: "dev.cengine.app.pkg",
            delete: ["/Applications/cengine.app", "/usr/local/bin/cengine"]

  zap trash: [
    "~/.cengine",
    "~/Library/Application Support/cengine",
    "~/Library/Caches/dev.cengine.app",
    "~/Library/Logs/cengine",
    "~/Library/Preferences/dev.cengine.app.plist",
    "~/Library/Saved Application State/dev.cengine.app.savedState",
  ]

  caveats <<~EOS
    Open cengine after a fresh install to enable its services. Upgrades resume a previously enabled engine.
    A standard reinstall restores an active cengine Docker context on the next engine start.
    A standard uninstall preserves VM and image data. To remove all cengine data instead:
      brew uninstall --cask --zap cengine
  EOS
end

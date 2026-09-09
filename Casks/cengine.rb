cask "cengine" do
  version "0.0.58"
  sha256 "5fe21baa662cfb2bcb76c82b9e16de7e2c8a1497b6d6c5bd906b335793f66e93"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.58/cengine-0.0.58.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using one raw Linux VM per container"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on formula: "docker"

  pkg "cengine-0.0.58.pkg"

  postflight_steps do
    # Older Homebrew versions do not accept must_succeed on run steps.
    # Opening the app is best effort, including on headless CI runners.
    run "/bin/sh",
        args: [
          "-c", '"$@" || true', "--", "/usr/bin/open",
          "/Applications/cengine.app", "--args", "--opened-by-installer",
        ]
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

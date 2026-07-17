cask "cengine" do
  version "0.0.33"
  sha256 "627e0ea0950d1d91f4c048238d860052594874e1f45ab0ecc259f6d6dd2a0b4e"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.33/cengine-0.0.33.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using one raw Linux VM per container"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-0.0.33.pkg"

  postflight do
    system_command "/usr/bin/open",
                   args: ["/Applications/cengine.app"],
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
    cengine launches after installation and upgrades so enabled services use the installed version.
    A standard uninstall preserves VM and image data. To remove all cengine data instead:
      brew uninstall --cask --zap cengine
  EOS
end

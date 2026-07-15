cask "cengine" do
  version "0.0.23"
  sha256 "cfd72dd375b8e246abab9c6c84d185a4b382f09ef4d5286b5da9ae9d2512d805"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.23/cengine-0.0.23.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using one raw Linux VM per container"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-0.0.23.pkg"

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
    "~/Library/Logs/cengine",
  ]
end

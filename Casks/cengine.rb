cask "cengine" do
  version "0.0.14"
  sha256 "e5493e4ef15bef1947dc94c062756ebc17e50658de392b4ed8ec8b4736701a18"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.14/cengine-0.0.14.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-0.0.14.pkg"

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

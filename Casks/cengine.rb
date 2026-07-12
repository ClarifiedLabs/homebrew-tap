cask "cengine" do
  version "0.0.10"
  sha256 "d70a9ad2ef3e8e65d80e7ac8ae0f38f25a5a9c53e5dd5cb313ec505445b83c60"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.10/cengine-0.0.10.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-0.0.10.pkg"

  uninstall early_script: {
              executable: "/Applications/cengine.app/Contents/MacOS/cengine",
              args: ["--uninstall-support"],
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

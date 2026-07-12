cask "cengine" do
  version "0.0.11"
  sha256 "d92a39265dfab754f35f3097f7d88b491b1f33afc67e752c1bb64f1cd22dc98d"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.11/cengine-0.0.11.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-0.0.11.pkg"

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

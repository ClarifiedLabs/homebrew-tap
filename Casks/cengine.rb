cask "cengine" do
  version "0.0.1"
  sha256 "7061128b7055864b0519871acd0c01d43c602a5b53314ddeea3ce9193fbb82b9"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v#{version}/cengine-#{version}.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-#{version}.pkg"

  uninstall pkgutil: "dev.cengine.engine.pkg"
end

cask "cengine" do
  version "0.0.4"
  sha256 "e09347ffaef438d17b88f07e2a3d9903a9847f4d763aa6df5cd165cbe8c3eeb8"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v#{version}/cengine-#{version}.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-#{version}.pkg"

  uninstall pkgutil: "dev.cengine.engine.pkg"
end

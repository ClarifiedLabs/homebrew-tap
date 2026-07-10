cask "cengine" do
  version "0.0.3"
  sha256 "492c98574abd394292dda27d70862073aedc178c15f55548dc2bdb15144c4594"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v#{version}/cengine-#{version}.pkg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "cengine-#{version}.pkg"

  uninstall pkgutil: "dev.cengine.engine.pkg"
end

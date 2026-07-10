cask "cengine" do
  version "0.0.5"
  sha256 "ddf4f91b02842c3ebeee167d7b5ea4156fa6cb244a73b3c2e02356b6e5fc7a0c"

  url "https://github.com/ClarifiedLabs/cengine/releases/download/v#{version}/cengine-#{version}.dmg"
  name "cengine"
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  binary "cengine"
end

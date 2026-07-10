cask "macvm" do
  version "0.0.4"
  sha256 "945db6d571ac1e69f1d262a0fb8a1539d54725ba55cfc79b5f26a1da492a3bba"

  url "https://github.com/ClarifiedLabs/macvm/releases/download/v#{version}/MacVM-#{version}.pkg"
  name "MacVM"
  desc "Create and run macOS virtual machines on Apple silicon"
  homepage "https://github.com/ClarifiedLabs/macvm"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "MacVM-#{version}.pkg"

  uninstall pkgutil: "dev.macvm.macvm.pkg"
end

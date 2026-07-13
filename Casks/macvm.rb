cask "macvm" do
  version "0.0.9"
  sha256 "0be650f1451e9d17a327272e0906c4a7cbd21bfc0de43eb866f904ab0ee10c5d"

  url "https://github.com/ClarifiedLabs/macvm/releases/download/v#{version}/MacVM-#{version}.pkg"
  name "MacVM"
  desc "Create and run macOS virtual machines on Apple silicon"
  homepage "https://github.com/ClarifiedLabs/macvm"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  pkg "MacVM-#{version}.pkg"

  caveats <<~EOS
    Ansible is optional and is required only when using provisioning profiles:
      brew install ansible
  EOS

  uninstall pkgutil: "dev.macvm.macvm.pkg"
end

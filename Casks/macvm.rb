cask "macvm" do
  version "0.0.7"
  sha256 "6bf0b35ed4e0dd6b55965bc3f20a3930f80c5e5be71ae2fc832a58a5f1c6ac96"

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

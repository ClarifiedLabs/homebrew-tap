cask "macvm" do
  version "0.0.8"
  sha256 "7264399a3f0aea3e97c4aafb9d318917446ad2bde2a71f1a406a355d6b916c79"

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

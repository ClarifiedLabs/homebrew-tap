cask "macvm" do
  version "0.0.6"
  sha256 "68583be74ac59f84031e76058ad7df91759546b61a8dd995a9c770893de8bcb4"

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

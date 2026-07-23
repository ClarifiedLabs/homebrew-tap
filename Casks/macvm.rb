cask "macvm" do
  version "0.0.18"
  sha256 "b3d6f2fe6a576558d8422eb48dc8a95767fdd775d60429dab6df20080d76cc6f"

  url "https://github.com/ClarifiedLabs/macvm/releases/download/v#{version}/MacVM-#{version}.dmg"
  name "MacVM"
  desc "Create and run macOS virtual machines on Apple silicon"
  homepage "https://github.com/ClarifiedLabs/macvm"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "MacVM.app"
  binary "#{appdir}/MacVM.app/Contents/Helpers/macvm"

  uninstall quit: "dev.macvm.macvm"

  caveats <<~EOS
    Ansible is optional and is required only when using provisioning profiles:
      brew install ansible
  EOS
end

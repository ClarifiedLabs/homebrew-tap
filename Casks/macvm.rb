cask "macvm" do
  version "0.0.26"
  sha256 "45dc495850a5ef96ab8f6fafba15ce030ea3a0d36b5641c09d84bbc11a4721fb"

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

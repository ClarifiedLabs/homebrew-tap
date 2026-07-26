cask "macvm" do
  version "0.0.20"
  sha256 "38a95c60352a565562dbf7617275521f95b5d96bc6a6bd7b300aa50e1afee86d"

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

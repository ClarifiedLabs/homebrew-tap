cask "macvm" do
  version "0.0.14"
  sha256 "ad3238505ced80254f3fc0276d53c0b9d7307f79cdaf218853460924d9161145"

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

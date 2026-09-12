class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.43.tar.gz"
  sha256 "8d630661ac1b31118db52d87a67520223591fe61ec416adca12297f5607b3eeb"
  version "0.5.43"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.43"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "36bbc280d2071bfb5bd94de7e6502637e886bcc9ce34f11492a8e3dc025435d1"
  end

  depends_on "harness"
  depends_on "harness-model-proxy"
  depends_on "harness-mcp-proxy"

  def install
    pkgshare.mkpath
    (pkgshare/"README").write "harness-full installs the harness CLI, model proxy, and MCP proxy formulae.\n"
  end

  test do
    assert_predicate HOMEBREW_PREFIX/"bin/harness", :exist?
    assert_predicate HOMEBREW_PREFIX/"bin/harness-model-proxy", :exist?
    assert_predicate HOMEBREW_PREFIX/"bin/harness-mcp-proxy", :exist?
  end
end

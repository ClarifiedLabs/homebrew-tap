class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.41.tar.gz"
  sha256 "0fc88913e4cc8708957b2bc2940c5ff99cc5a089882efa85f3432f1023fddd4a"
  version "0.5.41"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.41"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1f9e3bf85b1017258bc1da0ffc03197a767f4871079f96c27daf25a6fbf226a5"
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

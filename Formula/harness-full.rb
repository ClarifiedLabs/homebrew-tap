class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "2e84cd9eed5cd5d9c122bbde84180531b56aec1fe632f0f8fdc519246674e341"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.21"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "34b738ae4185a72ae2e628bac181bdc0063f555d03b1a1513650863001fd5563"
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

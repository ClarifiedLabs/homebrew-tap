class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "cc62f931a78fa1d9c8d2c6feef0f4b43880a2e0b5fc4345afe997afdbafe0276"
  version "0.5.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "88fe84ab7bd597809b60873d05741caabc35acad484b5c5ba412e3103420a9d0"
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

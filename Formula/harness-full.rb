class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.13.tar.gz"
  sha256 "680910cac1d766a0fc3b735ad6a14e2e349f737a63d86d0d9bc4c2b9add09f0f"
  version "0.5.13"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.13"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c2ffecde7b0c6f6a332b6cf052f664387e7c68a8415e149051bc8eb273c44b97"
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

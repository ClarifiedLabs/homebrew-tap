class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.68.tar.gz"
  sha256 "c381994b3e9613bcdab64b5296faaf18df48f8f043561c9499cf98bf90b82e2c"
  version "0.5.68"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.68"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d1170d0ae19c6f90f2e99a56c7f8902b565bdfa44d2f91b6e2462f77384e10e2"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "cf2d3cf99b2400b57730f842d4b2c48cffc700e93354b5b2ba93a7047c32180c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "29ade6529c4202e7ed7ddcc6d85fd47aa5b5a90eade977ec38726b8de5c33b7b"
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

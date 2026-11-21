class HarnessFull < Formula
  desc "Meta formula for the harness CLI and proxy binaries"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.69.tar.gz"
  sha256 "c00372a2da0cc1d5f9315fd700d7266197589f6d54d554fe476534dbfc3b0e42"
  version "0.5.69"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.69"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "08c2585618973de1796c7e69428cf97569cd7e0e2e9976670ba257daa78b7fd5"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "6943c6a120106f5da28d9219b636101dfba73446dd637bbd5f22511c8d22d4e8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc0e053340546f74fae0b71d843e3bcbf02f162c2b6e6ad247231486b31e8c4b"
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

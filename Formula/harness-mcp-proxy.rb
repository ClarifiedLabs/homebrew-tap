class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.41.tar.gz"
  sha256 "0fc88913e4cc8708957b2bc2940c5ff99cc5a089882efa85f3432f1023fddd4a"
  version "0.5.41"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.41"
    sha256 cellar: :any, x86_64_linux: "29bb19856c52881125e803dabe65471c3b0430fc44102fd25f50173eb9aa82ab"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-mcp-proxy", "./cmd/harness-mcp-proxy"
  end

  test do
    assert_match "harness-mcp-proxy v#{version}", shell_output("#{bin}/harness-mcp-proxy --version")
  end
end

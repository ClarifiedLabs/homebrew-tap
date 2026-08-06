class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "cc62f931a78fa1d9c8d2c6feef0f4b43880a2e0b5fc4345afe997afdbafe0276"
  version "0.5.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.1"
    sha256 cellar: :any, x86_64_linux: "48d22b04f3a873019e70ea4f820fa7f74a77c1c82d0ee6a3bd38f91694c4313f"
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

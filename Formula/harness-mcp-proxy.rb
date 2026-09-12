class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.43.tar.gz"
  sha256 "8d630661ac1b31118db52d87a67520223591fe61ec416adca12297f5607b3eeb"
  version "0.5.43"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.43"
    sha256 cellar: :any, x86_64_linux: "f32513697c89069e23e2ee7d5fd1759aa6757558e54f9388e4a58c6c282dec10"
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

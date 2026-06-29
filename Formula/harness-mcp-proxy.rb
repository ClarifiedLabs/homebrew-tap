class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "2e84cd9eed5cd5d9c122bbde84180531b56aec1fe632f0f8fdc519246674e341"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "55968b908ad019fde7180bfad5b5428327ca6b2ab940835ff279ec6f0660b07d"
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

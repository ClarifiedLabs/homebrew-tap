class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.60.tar.gz"
  sha256 "3cd99ac7b51ba4254629a856ed9da693e986aff64e5f598c5f3f39a6f754517b"
  version "0.5.60"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.60"
    sha256 cellar: :any, x86_64_linux: "ff2cafd0c5842965bd59ee3d2f8ed98c2274a3ca143b114b54bb0bac5d945a7a"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
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

class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.69.tar.gz"
  sha256 "c00372a2da0cc1d5f9315fd700d7266197589f6d54d554fe476534dbfc3b0e42"
  version "0.5.69"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.69"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "bc177d6743dbb0ee7b851d16b4b76ad13157ec0216f385443ad418203e12f903"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3f3287427a1d824faef037b80beb8528e997e1bb01b80cb7e763cccd74c39ef1"
    sha256 cellar: :any,                 x86_64_linux: "b051139635ef1e67a13bc1072f0647a03d895d0e58a2c94809253c43a6fdf15e"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-mcp-proxy", "./cmd/harness-mcp-proxy"
    doc.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "harness-mcp-proxy v#{version}", shell_output("#{bin}/harness-mcp-proxy --version")
  end
end

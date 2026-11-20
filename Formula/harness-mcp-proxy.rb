class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.67.tar.gz"
  sha256 "cf7c327e3a30cf7627a12c0e0c30adf75642853124f407497ccde4c64f6b1ab5"
  version "0.5.67"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.67"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "75d4317e7b46a96a0d88e8ec5a76d7d3b2a57d2152b3c7334dc8d1ffdbcfaf6c"
    sha256 cellar: :any_skip_relocation, arm64_linux: "09b45599d5bde70da8b836902b004cc33e15c8d5bc2347ff9df98f7a1cc7f9c0"
    sha256 cellar: :any, x86_64_linux: "d27758a93c7cc54a79b81efc28878df2d2c605271737b4390b4f616499e2a395"
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

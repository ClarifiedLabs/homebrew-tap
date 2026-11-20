class HarnessMcpProxy < Formula
  desc "MCP proxy daemon and debug client for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.68.tar.gz"
  sha256 "c381994b3e9613bcdab64b5296faaf18df48f8f043561c9499cf98bf90b82e2c"
  version "0.5.68"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.68"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2553023a280bd0599e533a2e53556433fe676afc592d20d9557288c678ea8071"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "ace779940b85ae5b0a572a43bb6d6c62bf176678b577ef0edc3fee4df41ec81a"
    sha256 cellar: :any,                 x86_64_linux: "99be7b5bd669323cca14ac852d7e3a77dd065fb169f2156ebb00206406197171"
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

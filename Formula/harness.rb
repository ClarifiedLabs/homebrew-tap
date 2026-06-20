class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.10.tar.gz"
  sha256 "cc4733c344e56cae87c559c2cd2c7009f1b939b321ad863c0c0580a834f9a0e7"
  version "0.0.10"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.10"
    sha256 cellar: :any, x86_64_linux: "8e00a386415b8599d1a8cc4964697e5e8c68969782e24ab7994ce1b7a1a9d9aa"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness", "./cmd/harness"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-mcp-proxy", "./cmd/harness-mcp-proxy"
  end

  test do
    assert_match "harness v#{version}", shell_output("#{bin}/harness --version")
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
    assert_match "harness-mcp-proxy v#{version}", shell_output("#{bin}/harness-mcp-proxy --version")
  end
end

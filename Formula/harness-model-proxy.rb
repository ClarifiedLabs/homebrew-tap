class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.60.tar.gz"
  sha256 "3cd99ac7b51ba4254629a856ed9da693e986aff64e5f598c5f3f39a6f754517b"
  version "0.5.60"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.60"
    sha256 cellar: :any, x86_64_linux: "9522437831b1422205d5cb9260da8e2f85084e01e96189eb7678ba09995eb735"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
  end

  test do
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
  end
end

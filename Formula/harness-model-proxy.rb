class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.41.tar.gz"
  sha256 "0fc88913e4cc8708957b2bc2940c5ff99cc5a089882efa85f3432f1023fddd4a"
  version "0.5.41"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.41"
    sha256 cellar: :any, x86_64_linux: "ed10952bf536ba86fd9aaf77362d6956d4b1a41921e3324958e8cf03422c4f30"
  end

  depends_on "go" => :build

  def install
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

class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "450ecae13ec73f1ca9c6b2f5a8ebd4300307151bf8d5de9b379a72548a95a0b6"
  version "0.3.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.3.2"
    sha256 cellar: :any, x86_64_linux: "2277d2d47cf814b382c9c5b1816df833ebbbfc6a283362a32c935d5eb24b198e"
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

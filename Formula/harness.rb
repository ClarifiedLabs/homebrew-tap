class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.38.tar.gz"
  sha256 "8b8b389bf014cf2a6c074f9fd8a1080151edda0a09c8cacf50d95aea53db0783"
  version "0.5.38"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.38"
    sha256 cellar: :any, x86_64_linux: "bcacebfc40d99370519b96b48f17040d0ef28b35cd1796577de3c762c4d33fdc"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness", "./cmd/harness"
  end

  test do
    assert_match "harness v#{version}", shell_output("#{bin}/harness --version")
  end
end

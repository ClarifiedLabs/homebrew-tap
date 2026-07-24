class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "64d71764b65229da2b86c67a78100cfc6450b56ae593e8b852a55339c6cef3ca"
  version "0.2.0"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.2.0"
    sha256 cellar: :any, x86_64_linux: "d65732bc2639d00b63fd4fcac46ae0dbd75b1c1b285c85e40bb21fda34c08ad7"
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

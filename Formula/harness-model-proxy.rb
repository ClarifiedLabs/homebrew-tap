class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "2e84cd9eed5cd5d9c122bbde84180531b56aec1fe632f0f8fdc519246674e341"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "b7352414e1857037303fe2f4cee0a725637fb466280f8c32b62b00db7d03f282"
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

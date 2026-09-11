class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.41.tar.gz"
  sha256 "0fc88913e4cc8708957b2bc2940c5ff99cc5a089882efa85f3432f1023fddd4a"
  version "0.5.41"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.41"
    sha256 cellar: :any, x86_64_linux: "ffb3640e0d44848b89b2edb26ca894618107119562d0a52e2effc95ecf93adc3"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.38.tar.gz"
  sha256 "415e186a982c12def315dfdb1e6263997ff3047b884cc9d67630919c4d87440f"
  version "0.0.38"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.38"
    sha256 cellar: :any, x86_64_linux: "a28286a85d982d88fd2a8c2814c1fdfdc3299a0bb11750bb393cedd8211d0c25"
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

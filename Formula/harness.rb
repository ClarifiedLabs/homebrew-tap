class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "adc24fcb1c2998cc4d1f3bf3e6f87c51863858c1ad77e48c0d9d801516fa31d7"
  version "0.3.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.3.1"
    sha256 cellar: :any, x86_64_linux: "8e76582fc0ca012efe556f1031365a28fec305b88e30906d4daa340747de0d13"
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

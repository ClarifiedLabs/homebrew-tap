class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.26.tar.gz"
  sha256 "28c6d671967acadc578f5acb18007141e97e6aba8dfb3fb23b83f64608d68016"
  version "0.5.26"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.26"
    sha256 cellar: :any, x86_64_linux: "a56bd0a1e57ec8b897e6eae06f0b0293057ec9b749b434ef415a2d9e78c7e6a9"
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

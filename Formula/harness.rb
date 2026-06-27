class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.16.tar.gz"
  sha256 "b5324f6816d5f4ea713e05baa4dd020dd7ace8b98944ed0e8e4a7b2b3bac9050"
  version "0.0.16"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.16"
    sha256 cellar: :any, x86_64_linux: "5ed3fce5ce5d88cf7a7b8c1e527658ba67c656159fd4eaf9cbdfb012a8724041"
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

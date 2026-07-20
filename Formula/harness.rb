class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4e43bb76a2b23a663763a25dca149e017b422b26e8dbce2313c400fe1d04b3c1"
  version "0.1.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.1.1"
    sha256 cellar: :any, x86_64_linux: "bc1757cbba34c0cedb6ef6ed44f70df8fe65e022b83a54e8ce2edc1beee93364"
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

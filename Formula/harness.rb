class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.10.tar.gz"
  sha256 "acbdfd8d1e25fea3b2519e9c64557c58e364b5ed151cfc9a321bbbd72f50f549"
  version "0.5.10"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.10"
    sha256 cellar: :any, x86_64_linux: "7856cdfe4215936fdbf9bea1f658437561608d318c37bd0a58eba8a86c6a0efb"
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

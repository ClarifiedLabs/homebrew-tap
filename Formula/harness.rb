class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "360caf956d00c819f4d209a18db7d96eee3ec55b359afd2ab5b3404ae1ac7dad"
  version "0.1.5"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.1.5"
    sha256 cellar: :any, x86_64_linux: "b6858c159c91aeb5adcc2d2e81447924074750f79eae35b97875178b737ad783"
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

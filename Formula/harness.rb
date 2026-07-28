class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "fb0c68f4897dad15d7d3e92019a0482fafcf8b09c3ed41deb8386acea848fccc"
  version "0.4.0"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.4.0"
    sha256 cellar: :any, x86_64_linux: "ae14a89e2db0e55ae3b2ba43b6decc7b1c37110a63db2dde3ee3a40bb12d4f8f"
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

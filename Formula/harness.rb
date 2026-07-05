class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.24.tar.gz"
  sha256 "a6dcada11da499c79f015ff3579414fee70c5562f89c86e0f0348869f7158ed3"
  version "0.0.24"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.24"
    sha256 cellar: :any, x86_64_linux: "973bb2ad6c25e09a75f0271e7374cbd5829fc408c1090e8ee5527121cf08c7df"
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

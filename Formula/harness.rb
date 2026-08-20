class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.16.tar.gz"
  sha256 "b983c0ccfb27400ddfdc84951464133a51c9eb532dbce00e8a43e7619739d46e"
  version "0.5.16"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.16"
    sha256 cellar: :any, x86_64_linux: "ed54e2a4429baf6bf512cc11db4573dcb8d26d518305333e1b8ee5dcfc284cc9"
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

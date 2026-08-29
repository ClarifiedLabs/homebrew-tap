class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.24.tar.gz"
  sha256 "b05cfeabe90c09ccd2a60ee0d54ca79d7c943908a0806360e9bbc54ee362aff6"
  version "0.5.24"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.24"
    sha256 cellar: :any, x86_64_linux: "f0214ed3577e67928055e5887004c5fae35ec3296bcba6bd4df3fe56f56c6410"
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

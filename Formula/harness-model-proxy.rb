class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.24.tar.gz"
  sha256 "b05cfeabe90c09ccd2a60ee0d54ca79d7c943908a0806360e9bbc54ee362aff6"
  version "0.5.24"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.24"
    sha256 cellar: :any, x86_64_linux: "5f8a2d2ee2d8d01e069ef4f46011c52cd41cfe1fe5b3c291f9b6dfc4be7aeb25"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
  end

  test do
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
  end
end

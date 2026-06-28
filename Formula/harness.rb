class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.18.tar.gz"
  sha256 "46f26aec5efab77c577ed02dc4d899dd0406fc90976a9db7ea112c846cac7223"
  version "0.0.18"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.18"
    sha256 cellar: :any, x86_64_linux: "2ab50f88176575f3a23ba9f6d7fc9b8e23bb1b6de6ac4c50bab7ecdce04de1e9"
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

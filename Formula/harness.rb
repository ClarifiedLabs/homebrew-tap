class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.27.tar.gz"
  sha256 "53bc116f6acc04b0911a970b3f536d98a541d3f785f549d14917040c7e84ce69"
  version "0.0.27"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.27"
    sha256 cellar: :any, x86_64_linux: "31b469a2f58383705a92659e9643a3e361ba8bd43e4c8b4c10cd9e7fe9a6bd81"
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

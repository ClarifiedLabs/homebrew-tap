class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.27.tar.gz"
  sha256 "63fb6dd43ae81600e7c1b52cb7e52774331bf1f26e5fc5fe0d8aeecddefcdf9b"
  version "0.5.27"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.27"
    sha256 cellar: :any, x86_64_linux: "cd41c2d47ca58c51e538137e1eaea959bb2baed795d52c3a0882332558b195f1"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.2.3.tar.gz"
  sha256 "3cced662483daaaf567083d85709f46e2647e64b6c88376e40fa857da16e34d2"
  version "0.2.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.2.3"
    sha256 cellar: :any, x86_64_linux: "b831cec405c3a7ea0a52ec22da2ca1a24c314a87cc92299aefdfa7458ecba3c0"
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

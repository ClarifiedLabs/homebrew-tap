class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.3.tar.gz"
  sha256 "bc9ea1272a60152d69bb75d7ed8b0141758f44d902bd56d3e0210601bb6fd876"
  version "0.5.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.3"
    sha256 cellar: :any, x86_64_linux: "9ae64794190b5d12318ba350dfbf1e3a41627944b744aac494c6e463409df48c"
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

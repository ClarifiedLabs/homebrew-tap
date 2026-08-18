class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.15.tar.gz"
  sha256 "6177fae8256697c510e22767a620a95dfcccc7ef6e496c7381ca44f2bb2a6600"
  version "0.5.15"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.15"
    sha256 cellar: :any, x86_64_linux: "1f0f60ea0a008c5c493b5de7a5464117413454192feecd759ecd2f895398b5d8"
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

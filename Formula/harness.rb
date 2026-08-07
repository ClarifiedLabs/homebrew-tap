class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "8dd7a54afc1d5fb03c58f2d93aa6e89f01af210f63874e49d0b908a4e8d72f45"
  version "0.5.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.2"
    sha256 cellar: :any, x86_64_linux: "a1737a16edf15e116d7a58affbc29395399abc440f51788d4c77d2efb5e3fbb0"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "450ecae13ec73f1ca9c6b2f5a8ebd4300307151bf8d5de9b379a72548a95a0b6"
  version "0.3.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.3.2"
    sha256 cellar: :any, x86_64_linux: "7827c3a1704c94d53d7ff95a08ae5764da715df23cca8b65e15be417a4a56c43"
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

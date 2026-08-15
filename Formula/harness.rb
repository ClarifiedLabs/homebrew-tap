class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.11.tar.gz"
  sha256 "820a2fb8c379eb6fd23782cfc38a6e8137465f1434568dca7a32bf2e1e435baa"
  version "0.5.11"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.11"
    sha256 cellar: :any, x86_64_linux: "1bd0e72b99a3aa8ffaefdb405bdf37d46b468f51216901ac3fba925c6525d7bd"
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

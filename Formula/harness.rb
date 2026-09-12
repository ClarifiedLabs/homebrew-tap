class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.43.tar.gz"
  sha256 "8d630661ac1b31118db52d87a67520223591fe61ec416adca12297f5607b3eeb"
  version "0.5.43"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.43"
    sha256 cellar: :any, x86_64_linux: "7ee01f5d602e45ee0fed27e2ad3d18e6c331a7819a31b3b10629d7a66665ebc6"
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

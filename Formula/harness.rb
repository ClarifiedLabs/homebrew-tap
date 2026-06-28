class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.19.tar.gz"
  sha256 "34308435b5cc89f272af386db4a7f9638cd69f5023068e62d80226228b1fcc90"
  version "0.0.19"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.19"
    sha256 cellar: :any, x86_64_linux: "265edf8de0d86ff5030df78c0ea51d7d655eb17200e2933c72fa9a0ec3c87ab4"
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

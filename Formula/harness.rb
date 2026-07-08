class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.28.tar.gz"
  sha256 "e0b06bd77b4b1ad0c5b6fe07d2d85aa62482c22b64e7b68340243d3ff4a99bb6"
  version "0.0.28"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.28"
    sha256 cellar: :any, x86_64_linux: "ab1f6aec45270116eb1594c43840d35a3212ecb44a6969c3de7d6c04b485ef23"
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

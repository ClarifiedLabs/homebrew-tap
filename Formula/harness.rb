class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.15.tar.gz"
  sha256 "bed8a1e76dc9b61acf1f26e7950f2fe45e493dc4bd90bc0fae443cefb584c6d1"
  version "0.0.15"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.15"
    sha256 cellar: :any, x86_64_linux: "0f9f361701fe3bb55d8607e7521382ababeff85a2a272a64d5411345a28ddc5e"
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

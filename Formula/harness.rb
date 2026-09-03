class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.30.tar.gz"
  sha256 "b52dc3b87ced107a844b323e5befc664cd9221e483b2f6a33dc9ba92f04dfd0f"
  version "0.5.30"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.30"
    sha256 cellar: :any, x86_64_linux: "27c90667f57146284fea2636e16834c1b50350c93f439bc84aaaf84f98fb015e"
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

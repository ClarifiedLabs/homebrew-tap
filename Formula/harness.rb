class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.45.tar.gz"
  sha256 "8f9528a5c07f4c1d68df1794338ed51c2fef595e0c7b5a876f96179e83f5cad8"
  version "0.5.45"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.45"
    sha256 cellar: :any, x86_64_linux: "dc629186cd7fb5bf08e2e6c0fc29c9b7f2cf167d757a3a81a7b7eb166a5fd7fd"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
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

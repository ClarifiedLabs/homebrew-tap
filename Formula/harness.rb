class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.19.tar.gz"
  sha256 "5d17159db9ee52d810fc7f9d9cdb969f43ce70734fd68ecad1ed19e7b9d23f71"
  version "0.5.19"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.19"
    sha256 cellar: :any, x86_64_linux: "9c4a9f39ef83764b99bdd9534344f4f5258ab1347650568e6f16ac66fcb0b820"
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

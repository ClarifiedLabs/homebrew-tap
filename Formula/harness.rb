class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.14.tar.gz"
  sha256 "fd01156aa0dd259f0dd743151fadca4e9f27c4a4617b36efa460aee9aaea3320"
  version "0.5.14"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.14"
    sha256 cellar: :any, x86_64_linux: "e91352a8264b54f9edf3d8a064305a7b1a3fc4962e0f91d20fde9a5ecd17b05a"
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

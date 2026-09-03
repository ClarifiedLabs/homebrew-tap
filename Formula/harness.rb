class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.32.tar.gz"
  sha256 "6fa36d9da1f4c39afd7e3bcf82c8566b83b820325afd8d7ed82f4f2ba8c8e2ed"
  version "0.5.32"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.32"
    sha256 cellar: :any, x86_64_linux: "a26e0ef0751243b7bb4982d5d441e196eb01c892db99b565056d86d46b639b2c"
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

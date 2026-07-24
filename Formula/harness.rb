class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "e4b9a39055e43b8646d45f8a29bbf3bd4cb58a0f7b0fc8559170c8f79e959b97"
  version "0.2.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.2.1"
    sha256 cellar: :any, x86_64_linux: "ae5f8a83f4828bf72bb06e92e8e23d5dcc546ddc587d6da4c958de18e75ded6f"
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

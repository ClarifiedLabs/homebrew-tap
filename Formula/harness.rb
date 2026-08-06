class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "cc62f931a78fa1d9c8d2c6feef0f4b43880a2e0b5fc4345afe997afdbafe0276"
  version "0.5.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.1"
    sha256 cellar: :any, x86_64_linux: "90baf92108fe31c48543851a72f7cb80b5d0d09874f18e9dac00cd5d7a22b828"
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

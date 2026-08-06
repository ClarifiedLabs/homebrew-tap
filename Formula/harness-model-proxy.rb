class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "cc62f931a78fa1d9c8d2c6feef0f4b43880a2e0b5fc4345afe997afdbafe0276"
  version "0.5.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.1"
    sha256 cellar: :any, x86_64_linux: "c4bf71b489f517085f0b4bb1fbf37554df2f0180dfaaec7eb1d100f13bbdd2cd"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
  end

  test do
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
  end
end

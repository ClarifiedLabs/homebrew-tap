class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.13.tar.gz"
  sha256 "680910cac1d766a0fc3b735ad6a14e2e349f737a63d86d0d9bc4c2b9add09f0f"
  version "0.5.13"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.13"
    sha256 cellar: :any, x86_64_linux: "53c23228f070e5bdb5beae180274fa1133711995869d96600251aa82f2c17dfc"
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

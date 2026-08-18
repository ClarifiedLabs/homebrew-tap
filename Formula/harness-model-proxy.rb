class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.13.tar.gz"
  sha256 "680910cac1d766a0fc3b735ad6a14e2e349f737a63d86d0d9bc4c2b9add09f0f"
  version "0.5.13"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.13"
    sha256 cellar: :any, x86_64_linux: "529eea01ff74e77e54a724bdc18decec69712b8fe2407836e35b3ce3a8185a46"
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

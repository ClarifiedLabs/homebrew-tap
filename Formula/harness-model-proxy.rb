class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.32.tar.gz"
  sha256 "6fa36d9da1f4c39afd7e3bcf82c8566b83b820325afd8d7ed82f4f2ba8c8e2ed"
  version "0.5.32"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.32"
    sha256 cellar: :any, x86_64_linux: "a27700c5b21dcff4243ebbcb38fcc5adb2658aef3b133de8e0223a8ce77f747e"
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

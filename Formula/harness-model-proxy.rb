class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.55.tar.gz"
  sha256 "77b7f91df16a16af94e45f36ac19bb9ba23447ed428a3a6690cfc4f2013f6d06"
  version "0.5.55"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.55"
    sha256 cellar: :any, x86_64_linux: "30fc0697db275b30b3d3646603a81013ceb9759cdedbfe21fb0d4718d1e89a6b"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
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

class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.25.tar.gz"
  sha256 "65eb2f0ec443ccbd2eb0a6536cfa0fa477fdbbb5d72ea6f72a8396d38b6b9b1e"
  version "0.5.25"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.25"
    sha256 cellar: :any, x86_64_linux: "6e00719901635c3e9a1738c3391ca7da8f8d164f4e2a52121e79055075660f6a"
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

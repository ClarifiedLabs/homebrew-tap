class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.37.tar.gz"
  sha256 "df11c5b4af9d7675c039a1b4db410c393edcbfc6e85dcc1432e5ccf0b6abe49b"
  version "0.0.37"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.37"
    sha256 cellar: :any, x86_64_linux: "8a4a6f5e446b016a23e2cd37cec7d0496fd8a6c9e59a606a6517c0267fdf1815"
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

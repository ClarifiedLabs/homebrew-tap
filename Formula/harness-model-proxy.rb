class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.43.tar.gz"
  sha256 "8d630661ac1b31118db52d87a67520223591fe61ec416adca12297f5607b3eeb"
  version "0.5.43"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.43"
    sha256 cellar: :any, x86_64_linux: "315581b799d4f8108528b3095442ed3ea92d43c0d38cee9355501c7fc3abde8f"
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

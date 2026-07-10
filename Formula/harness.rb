class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.29.tar.gz"
  sha256 "88eeab9179b95e4aeb786a9bc3bd4f909e460a8184d38d97d40b0f8d366a3f7f"
  version "0.0.29"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.29"
    sha256 cellar: :any, x86_64_linux: "840d6df2a0f9c8a3a06f4a9078f16a24f347e426e535041ae7d24c6762c3d897"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.12.tar.gz"
  sha256 "96b87019ec5999faa92e62c0d4b34eb9a142214ab71b76da86f2451fce0eaf15"
  version "0.5.12"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.12"
    sha256 cellar: :any, x86_64_linux: "0428dff3ed65d513c6f24600682a16bc4096ab5f7b9e6f9b21d823d2e272e2dd"
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

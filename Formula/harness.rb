class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.26.tar.gz"
  sha256 "6ac92d37db4b20a700a1c4e1c619150816ed3bc7b88976c5bddc265f4596e5ff"
  version "0.0.26"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.26"
    sha256 cellar: :any, x86_64_linux: "85e61a568e97c60e3f039115450c91650ce45554593a8146d6954bc5e2c3ce75"
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

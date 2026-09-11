class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.40.tar.gz"
  sha256 "989e0fd94551d5abdd36930530fcd2b8c3dd7c86053089c4e04d6b4a830f17ad"
  version "0.5.40"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.40"
    sha256 cellar: :any, x86_64_linux: "8293558d3fda65b6fcc5a72df564e4197d1e6d29777d4be458d5142864d6d814"
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

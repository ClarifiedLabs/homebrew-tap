class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.23.tar.gz"
  sha256 "6f4fe12bd79c49c9bb13d6d09c1fb2761fe8b52014b679f755d1534d0f08477b"
  version "0.0.23"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.23"
    sha256 cellar: :any, x86_64_linux: "29b81881f776a4de83d9307a8ff58d27b69cf627230ea65a5214bc5ed4ef1409"
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

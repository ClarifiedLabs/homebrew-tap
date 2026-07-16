class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.34.tar.gz"
  sha256 "3a0b2a09f05ecac16a3ed771852229476a8e64877ad553a544511a9700b424c9"
  version "0.0.34"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.34"
    sha256 cellar: :any, x86_64_linux: "1649f4b39bab6e75134de71ea6bb1f15ea7c4393949dfdff8c54aefc4401eca2"
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

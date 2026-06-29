class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "2e84cd9eed5cd5d9c122bbde84180531b56aec1fe632f0f8fdc519246674e341"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "730adc9353014cae8b9b6792e9f9f59465bf8cce7fe694fdce31a6b5699edb25"
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

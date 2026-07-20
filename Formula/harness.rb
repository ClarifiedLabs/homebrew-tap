class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "398933fb977fe6e2ffdfdb1194409b99e4c0e805fa69f6bfb3c66c82cd75605d"
  version "0.1.0"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.1.0"
    sha256 cellar: :any, x86_64_linux: "ff7ee7ddf49d1320cfaecc96e183d55e2f9a33b736aae5acea4ee27259054d01"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "b1f01b1966df6f05284d8ff7ae70f401c7ad3624f065a5112bdbbb8d369b2970"
  version "0.3.4"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.3.4"
    sha256 cellar: :any, x86_64_linux: "cabf3f5629affb76d16c2032b81c4e5ed1313439254f4d4f11b3b7e375588f3e"
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

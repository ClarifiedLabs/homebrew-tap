class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.36.tar.gz"
  sha256 "9ddc6e9115962a239c010aa33af5281d4040a7cac99553d421e6fde4725cffc6"
  version "0.5.36"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.36"
    sha256 cellar: :any, x86_64_linux: "da5870b3e72f58c382d0ccf7ac097f132fe8c0b9d5c1ce296149df5fd41e742d"
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

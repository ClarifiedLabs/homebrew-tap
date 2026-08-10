class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.6.tar.gz"
  sha256 "3c9698635af6b0c73118ea523b823ef87ce577e46e6c43b190aeea7b06c50571"
  version "0.5.6"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.6"
    sha256 cellar: :any, x86_64_linux: "e40803dbb7cf633088684fe9407c7308b0abbaf4ccea11972ecb6a753145fe31"
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

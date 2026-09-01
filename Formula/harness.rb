class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.28.tar.gz"
  sha256 "7f13d3ca07dfb8f856af8ab92667a9adc6e47cbe8fa4c5b63027379a3ac3d56a"
  version "0.5.28"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.28"
    sha256 cellar: :any, x86_64_linux: "abea404db5ab18e6378e35e0ebaaca2252f3f8dac36930cbcdc530dd4238e7e6"
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

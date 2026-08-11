class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.8.tar.gz"
  sha256 "439d242fdff02212ecd8772a0e6ffbd4a730c45a74028cfc3d33a093d81b5c16"
  version "0.5.8"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.8"
    sha256 cellar: :any, x86_64_linux: "6b1f006ebe4db2af1a6407fe39f457118287aa1b6dcabe25b62cf6346180c73d"
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

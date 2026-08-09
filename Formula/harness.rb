class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.5.tar.gz"
  sha256 "784ac439e8ec6d300fec1bf3eac7f6855ebd0a9f6687dd3f61ac40613ee737a9"
  version "0.5.5"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.5"
    sha256 cellar: :any, x86_64_linux: "1af7c3d59daa435735b4cf730573c0e5301ffe92d217dd5bbda793aceee9af0b"
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

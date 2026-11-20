class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.68.tar.gz"
  sha256 "c381994b3e9613bcdab64b5296faaf18df48f8f043561c9499cf98bf90b82e2c"
  version "0.5.68"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.68"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "28dcad3bb4f1b106377f6ad10063dc06e516122637a78cfcd0257e18853ae724"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "5b90e62621563b8b30eb0e76f111e90f6c96492b8e0cae909fedc9ed91d7b080"
    sha256 cellar: :any,                 x86_64_linux: "9b4d4c7c5f7df74da24d0a185f7f8450a6d282e1b90f5d11a69528c89566757d"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness", "./cmd/harness"
    doc.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "harness v#{version}", shell_output("#{bin}/harness --version")
  end
end

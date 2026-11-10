class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.65.tar.gz"
  sha256 "2b90918932e2dabec2a7036fab11d896292be3fe90a3fc4d265bd16f10f0b060"
  version "0.5.65"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.65"
    sha256 cellar: :any, x86_64_linux: "350bd51382ef572a3e97424e6aa6e1be992b8934557cb1e515c87b1822c86aba"
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

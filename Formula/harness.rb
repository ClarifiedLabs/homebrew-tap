class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.63.tar.gz"
  sha256 "824b5aa83cdc36a91d94673b8af6cc3550224bc8167248115bcb5717022b7a0d"
  version "0.5.63"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.63"
    sha256 cellar: :any, x86_64_linux: "196235471549965f6892f9e29bfd1d6cf0d8a1f0e3ff27fd098a75a3a5b2a6a3"
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

class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.69.tar.gz"
  sha256 "c00372a2da0cc1d5f9315fd700d7266197589f6d54d554fe476534dbfc3b0e42"
  version "0.5.69"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.69"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cc09ad1aad9f824ece53eac78424715c00bbc482d1ddd4d4d4fac0e857a3d23f"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "532bfd6302637fe6322340005ef2d08605ec37db5c07eba8b94e8ae9d5a87723"
    sha256 cellar: :any,                 x86_64_linux: "96224e19c5ebc14a4ed4a66fb91e288a431622a7a20066821514c2a1e72cdd85"
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

class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.69.tar.gz"
  sha256 "c00372a2da0cc1d5f9315fd700d7266197589f6d54d554fe476534dbfc3b0e42"
  version "0.5.69"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.69"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3cbb7bff7a6ad8bac484a77f41e4702e172ebb45cf85d4e5bb08c91a6af285d1"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "3f2618bda02847ce54b26c3579034a07c8a590cf112090736874dd90f2ac7e9a"
    sha256 cellar: :any,                 x86_64_linux: "8765f9bbcec0b1649496452ed6eae9c72b68e5ea08ca809a821d52ccbb964334"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
    doc.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
  end
end

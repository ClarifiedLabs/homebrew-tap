class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.67.tar.gz"
  sha256 "cf7c327e3a30cf7627a12c0e0c30adf75642853124f407497ccde4c64f6b1ab5"
  version "0.5.67"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.67"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "410d5d1041a45fef318f1423cafaabd9ad1f4297ac109e9de7b3583197056e9a"
    sha256 cellar: :any_skip_relocation, arm64_linux: "61ff2312f5a099c4e83b23e7584f44ca3f1960c64017bcdc3649af013d92fd0e"
    sha256 cellar: :any, x86_64_linux: "9c414071bfd1fae4fda8276befd81e138044296b8193b06a91ff32896495f027"
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

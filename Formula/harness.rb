class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.37.tar.gz"
  sha256 "df11c5b4af9d7675c039a1b4db410c393edcbfc6e85dcc1432e5ccf0b6abe49b"
  version "0.0.37"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.37"
    sha256 cellar: :any, x86_64_linux: "19a79d362da90ea15aef907a9eb0e5e144617f99ca37d87c820bb0822e2b1b7d"
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

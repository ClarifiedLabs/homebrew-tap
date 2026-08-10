class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "9392b4eddbcadd9856276f7c4b2bccdd541b1091bef498d5bc64ab5e23908afd"
  version "0.0.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.7"
    sha256 cellar: :any, x86_64_linux: "d8aeda11e52f9c8ff9d2eaa30410d8f5508070669240bc927af5f6d2a2b88c78"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow", "./cmd/flow"

  end

  test do
    assert_match "flow v#{version}", shell_output("#{bin}/flow --version")
  end
end

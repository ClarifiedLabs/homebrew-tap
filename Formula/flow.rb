class Flow < Formula
  desc "CLI for local issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "1e20a93514a94031e7dda0294673bcebb8f1447ae9e2f5a2681dee83e1b56bff"
  version "0.0.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.3"
    sha256 cellar: :any, x86_64_linux: "71b737bddfa95685eb27275a76ee3df3d59183bece5c1f89e166c96185d0a90e"
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

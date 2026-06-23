class Flow < Formula
  desc "CLI for local issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "1a5a3593b1dc8034b668841877e682e23f152fe0603c33428ea50a52006b65d4"
  version "0.0.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.1"
    sha256 cellar: :any, x86_64_linux: "92493193ccfbc5675c94767b2408fffd87dbac67840d98cf17adaee1b75a4add"
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

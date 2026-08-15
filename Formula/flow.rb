class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.18.tar.gz"
  sha256 "ffcd7e2b99e3eb4abb48d7d47dbb251596bbcf2710ab40fe0bed998558768e16"
  version "0.0.18"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.18"
    sha256 cellar: :any, x86_64_linux: "45f3074fa06aa95e9eb48585cd0d7486eeab7b1f15367c1b5d90b4c41b97212a"
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

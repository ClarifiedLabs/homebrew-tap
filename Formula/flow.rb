class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "98ef850d3dd915238686dc76da491082144b37024243ed599f74d782707118c5"
  version "0.0.11"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.11"
    sha256 cellar: :any, x86_64_linux: "909cebb6385b4af1cffaa29b44c9b5a217f692eedc41b7a60dedd6126e628dd6"
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

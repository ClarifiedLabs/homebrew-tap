class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "98ef850d3dd915238686dc76da491082144b37024243ed599f74d782707118c5"
  version "0.0.11"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.11"
    sha256 cellar: :any, x86_64_linux: "8de1c5d70942ffe99a671eafcbf3942d410813a1950ff1d61a1dc077d1a57e45"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow-worker", "./cmd/flow-worker"

  end

  test do
    assert_match "flow-worker v#{version}", shell_output("#{bin}/flow-worker --version")
  end
end

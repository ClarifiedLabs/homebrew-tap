class FlowOrchestrator < Formula
  desc "Durable assignment orchestrator for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "98ef850d3dd915238686dc76da491082144b37024243ed599f74d782707118c5"
  version "0.0.11"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.11"
    sha256 cellar: :any, x86_64_linux: "b302194cc81bff49049dc057cac1c1cda8b5943f774226ea7434342d1c2ddce6"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow-orchestrator", "./cmd/flow-orchestrator"
    (pkgshare/"examples").install "examples/flow-orchestrator.yaml"
  end

  test do
    assert_match "flow-orchestrator v#{version}", shell_output("#{bin}/flow-orchestrator --version")
  end
end

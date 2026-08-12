class FlowOrchestrator < Formula
  desc "Durable assignment orchestrator for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.12.tar.gz"
  sha256 "a1a8ea6eba43c8fe485d2db48e0eab0acee863a78854e9c88793fbb373001730"
  version "0.0.12"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.12"
    sha256 cellar: :any, x86_64_linux: "c9a31365407f9cbd0ffe8d648b993ba1e39e19cb39bc416ac952a86013b0603a"
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

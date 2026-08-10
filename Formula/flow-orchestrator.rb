class FlowOrchestrator < Formula
  desc "Durable assignment orchestrator for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "d2b6ad415dc31bb56b85bfc84947633d6b8a7ea920416fce0b2977de809a3d3c"
  version "0.0.6"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.6"
    sha256 cellar: :any, x86_64_linux: "bb155a5e66073bf388b73436e1ec73e3c7182e415c4633a74a7b265e083619fd"
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

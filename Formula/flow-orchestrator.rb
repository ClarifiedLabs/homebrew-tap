class FlowOrchestrator < Formula
  desc "Durable assignment orchestrator for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "ffc14ca4faa20ffe2367d22711e335c67e62d543ecf5c8b0f22a115a3791eebd"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "1e095771869b64eb55bcb02521fe400b9b490a5ce15b01d145dd08effe705654"
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

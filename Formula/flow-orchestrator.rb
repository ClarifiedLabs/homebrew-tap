class FlowOrchestrator < Formula
  desc "Durable assignment orchestrator for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "9392b4eddbcadd9856276f7c4b2bccdd541b1091bef498d5bc64ab5e23908afd"
  version "0.0.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.7"
    sha256 cellar: :any, x86_64_linux: "fd33d98357551b3e4bfe6445d4543c533470966512d7ea4b7b1b28741ea992df"
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

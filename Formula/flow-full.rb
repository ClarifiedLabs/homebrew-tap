class FlowFull < Formula
  desc "All Flow commands for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "9392b4eddbcadd9856276f7c4b2bccdd541b1091bef498d5bc64ab5e23908afd"
  version "0.0.7"
  license "MIT"

  depends_on "clarifiedlabs/tap/flow"
  depends_on "clarifiedlabs/tap/flow-server"
  depends_on "clarifiedlabs/tap/flow-worker"
  depends_on "clarifiedlabs/tap/flow-orchestrator"

  def install
    pkgshare.install "README.md"
  end

  test do
    flow_bin = Formula["clarifiedlabs/tap/flow"].bin/"flow"
    server_bin = Formula["clarifiedlabs/tap/flow-server"].bin/"flow-server"
    worker_bin = Formula["clarifiedlabs/tap/flow-worker"].bin/"flow-worker"
    orchestrator_bin = Formula["clarifiedlabs/tap/flow-orchestrator"].bin/"flow-orchestrator"

    assert_match "flow v#{version}", shell_output("#{flow_bin} --version")
    assert_match "flow-server v#{version}", shell_output("#{server_bin} --version")
    assert_match "flow-worker v#{version}", shell_output("#{worker_bin} --version")
    assert_match "flow-orchestrator v#{version}", shell_output("#{orchestrator_bin} --version")
  end
end

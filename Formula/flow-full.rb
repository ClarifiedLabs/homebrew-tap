class FlowFull < Formula
  desc "All Flow commands for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.18.tar.gz"
  sha256 "ffcd7e2b99e3eb4abb48d7d47dbb251596bbcf2710ab40fe0bed998558768e16"
  version "0.0.18"
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

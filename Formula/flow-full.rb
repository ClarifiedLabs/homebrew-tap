class FlowFull < Formula
  desc "All Flow commands for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "23d4e75eecd0b04e4f2d4315ea17845cf5955903af154e616a3790fc97878120"
  version "0.0.2"
  license "MIT"

  depends_on "clarifiedlabs/tap/flow"
  depends_on "clarifiedlabs/tap/flow-server"
  depends_on "clarifiedlabs/tap/flow-worker"

  def install
    pkgshare.install "README.md"
  end

  test do
    flow_bin = Formula["clarifiedlabs/tap/flow"].bin/"flow"
    server_bin = Formula["clarifiedlabs/tap/flow-server"].bin/"flow-server"
    worker_bin = Formula["clarifiedlabs/tap/flow-worker"].bin/"flow-worker"

    assert_match "flow v#{version}", shell_output("#{flow_bin} --version")
    assert_match "flow-server v#{version}", shell_output("#{server_bin} --version")
    assert_match "flow-worker v#{version}", shell_output("#{worker_bin} --version")
  end
end

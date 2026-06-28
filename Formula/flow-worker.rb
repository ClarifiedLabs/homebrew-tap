class FlowWorker < Formula
  desc "Worker supervisor for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "1e20a93514a94031e7dda0294673bcebb8f1447ae9e2f5a2681dee83e1b56bff"
  version "0.0.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.3"
    sha256 cellar: :any, x86_64_linux: "3fbd9e6875a477ea744242b8b540a728640d5e8b4b9d45a064b6b302b0354c17"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow-worker", "./cmd/flow-worker"
    (pkgshare/"examples").install "examples/flow-worker.yaml"
    (pkgshare/"examples/docker").install "examples/docker/flow-worker.yaml"
  end

  test do
    assert_match "flow-worker v#{version}", shell_output("#{bin}/flow-worker --version")
  end
end

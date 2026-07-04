class FlowWorker < Formula
  desc "Worker supervisor for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "6bf470d90742dd36a2f74bc176f6b9c75ae2a6c22306c67376b6fb93e7d7420b"
  version "0.0.4"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.4"
    sha256 cellar: :any, x86_64_linux: "ee18de817383918e7869dfb5e7c14cac78e36b17b6c49410460c5f9bd1e4ec67"
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

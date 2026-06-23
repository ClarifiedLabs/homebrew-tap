class FlowWorker < Formula
  desc "Worker supervisor for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "1a5a3593b1dc8034b668841877e682e23f152fe0603c33428ea50a52006b65d4"
  version "0.0.1"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.1"
    sha256 cellar: :any, x86_64_linux: "a67313704fad5336a46a39dc469f2fc87bd6642353c2ee0fbc9a70371059f043"
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

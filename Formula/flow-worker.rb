class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "d2b6ad415dc31bb56b85bfc84947633d6b8a7ea920416fce0b2977de809a3d3c"
  version "0.0.6"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.6"
    sha256 cellar: :any, x86_64_linux: "5c297fb811c7756766747d541900014bdfa2a7757ebd7d05bb3df15cd448870b"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow-worker", "./cmd/flow-worker"

  end

  test do
    assert_match "flow-worker v#{version}", shell_output("#{bin}/flow-worker --version")
  end
end

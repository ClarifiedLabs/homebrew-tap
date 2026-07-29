class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.5.tar.gz"
  sha256 "d676b5008b5afc6e3b68c098c15509c99d2f8c0068c9f3de110f46408fd0e245"
  version "0.0.5"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.5"
    sha256 cellar: :any, x86_64_linux: "5f420dab0e5b99a5e677eb96a112e0e6ff22ba4114d473815b3d59a70b2bb83a"
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

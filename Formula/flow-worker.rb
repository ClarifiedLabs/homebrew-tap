class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.12.tar.gz"
  sha256 "a1a8ea6eba43c8fe485d2db48e0eab0acee863a78854e9c88793fbb373001730"
  version "0.0.12"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.12"
    sha256 cellar: :any, x86_64_linux: "eb0d41f2f7a46588a85affa22986f4e70cffca940acfe5700e300ad78fe30ad8"
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

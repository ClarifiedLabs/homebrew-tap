class FlowWorker < Formula
  desc "Worker supervisor for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "23d4e75eecd0b04e4f2d4315ea17845cf5955903af154e616a3790fc97878120"
  version "0.0.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.2"
    sha256 cellar: :any, x86_64_linux: "7d2608e1b4ef66490b4f2c2e80941cf66d19eacb1981409c56205c65128b72db"
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

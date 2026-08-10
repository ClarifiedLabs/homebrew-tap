class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "9392b4eddbcadd9856276f7c4b2bccdd541b1091bef498d5bc64ab5e23908afd"
  version "0.0.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.7"
    sha256 cellar: :any, x86_64_linux: "dc6a8aec81534cd830d27885c3c52c4ceae9c1d5366bd75ab8f1ac91e79cd535"
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

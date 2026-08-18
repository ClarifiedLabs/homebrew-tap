class FlowWorker < Formula
  desc "Worker supervisor for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "ffc14ca4faa20ffe2367d22711e335c67e62d543ecf5c8b0f22a115a3791eebd"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "2bac67cf5d9b94b0e3a8d8ff380507b4d1c645f590bb2a2e1603e74d4f173d05"
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

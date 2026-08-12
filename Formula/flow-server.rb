class FlowServer < Formula
  desc "Coordinator server for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.11.tar.gz"
  sha256 "98ef850d3dd915238686dc76da491082144b37024243ed599f74d782707118c5"
  version "0.0.11"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.11"
    sha256 cellar: :any, x86_64_linux: "b35021e6ef7d2b3d5f70ca0ce6a6e604686ddb8df3d5f9a5f5b393f5b0bb0c09"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow-server", "./cmd/flow-server"
    (pkgshare/"examples").install "examples/flow-server.yaml"
    (pkgshare/"examples/docker").install "examples/docker/flow-server.yaml"
  end

  test do
    assert_match "flow-server v#{version}", shell_output("#{bin}/flow-server --version")
  end
end

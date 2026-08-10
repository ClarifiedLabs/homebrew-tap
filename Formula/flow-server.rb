class FlowServer < Formula
  desc "Coordinator server for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "d2b6ad415dc31bb56b85bfc84947633d6b8a7ea920416fce0b2977de809a3d3c"
  version "0.0.6"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.6"
    sha256 cellar: :any, x86_64_linux: "840f604b8c759235cd0d6c9fc2d882943e270ff76289cc66440385724574c2bd"
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

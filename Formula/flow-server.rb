class FlowServer < Formula
  desc "Coordinator server for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "6bf470d90742dd36a2f74bc176f6b9c75ae2a6c22306c67376b6fb93e7d7420b"
  version "0.0.4"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.4"
    sha256 cellar: :any, x86_64_linux: "cfb1cc2d628530f2f1b06f4af02f357c415d4c1f4f961efcc23cfca0d9d0d8fc"
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

class FlowServer < Formula
  desc "Coordinator server for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "1e20a93514a94031e7dda0294673bcebb8f1447ae9e2f5a2681dee83e1b56bff"
  version "0.0.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.3"
    sha256 cellar: :any, x86_64_linux: "5c8a5e41a3e2c9170c1d65ddb5008e2941d0637cf7031e0379cd8a04f3d3f69b"
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

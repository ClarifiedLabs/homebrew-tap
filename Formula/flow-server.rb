class FlowServer < Formula
  desc "Coordinator server for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "9392b4eddbcadd9856276f7c4b2bccdd541b1091bef498d5bc64ab5e23908afd"
  version "0.0.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.7"
    sha256 cellar: :any, x86_64_linux: "ecbbd962106e0017ea4312e491be2f16d96aa24af94e4254f51d844eea45ab20"
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

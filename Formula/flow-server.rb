class FlowServer < Formula
  desc "Coordinator server for task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "ffc14ca4faa20ffe2367d22711e335c67e62d543ecf5c8b0f22a115a3791eebd"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "c5ace0230b9eb179f40f68142d91e6217cd9b6a92bb7d07330e66773e47247cd"
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

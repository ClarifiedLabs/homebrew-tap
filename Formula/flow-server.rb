class FlowServer < Formula
  desc "Coordinator server for issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "23d4e75eecd0b04e4f2d4315ea17845cf5955903af154e616a3790fc97878120"
  version "0.0.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.2"
    sha256 cellar: :any, x86_64_linux: "08f20e7603811ebfed768fedf173ddfabda3865c858e66b33b571cb8fa08cd2f"
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

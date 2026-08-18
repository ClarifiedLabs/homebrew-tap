class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.21.tar.gz"
  sha256 "ffc14ca4faa20ffe2367d22711e335c67e62d543ecf5c8b0f22a115a3791eebd"
  version "0.0.21"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.21"
    sha256 cellar: :any, x86_64_linux: "c74fef265def9bd961cbfe8b2f7df0d1d550209249322b7610318424a7e4ba54"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/flow/internal/version.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"flow", "./cmd/flow"

  end

  test do
    assert_match "flow v#{version}", shell_output("#{bin}/flow --version")
  end
end

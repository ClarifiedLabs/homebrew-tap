class Flow < Formula
  desc "CLI for local issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "6bf470d90742dd36a2f74bc176f6b9c75ae2a6c22306c67376b6fb93e7d7420b"
  version "0.0.4"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.4"
    sha256 cellar: :any, x86_64_linux: "a0d0eefddb96247cc5f8ded04b485d4fd77f9331bf2f2bcc6bd16ec706646333"
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

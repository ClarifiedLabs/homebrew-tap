class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.12.tar.gz"
  sha256 "a1a8ea6eba43c8fe485d2db48e0eab0acee863a78854e9c88793fbb373001730"
  version "0.0.12"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.12"
    sha256 cellar: :any, x86_64_linux: "7d2eefac00dfe758643a6e32db4430bab253e96860fb35e8ba0af869034071c2"
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

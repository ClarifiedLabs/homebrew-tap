class Flow < Formula
  desc "CLI for local issue-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "23d4e75eecd0b04e4f2d4315ea17845cf5955903af154e616a3790fc97878120"
  version "0.0.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.2"
    sha256 cellar: :any, x86_64_linux: "8705b88db7b23c92bfdbca03732f026c400904af65f807890bfe9d56da4c1c85"
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

class Flow < Formula
  desc "CLI for local task-driven agent work"
  homepage "https://github.com/ClarifiedLabs/flow"
  url "https://github.com/ClarifiedLabs/flow/archive/refs/tags/v0.0.20.tar.gz"
  sha256 "f8826d24416ea641ff5a41bf67d69d4bfe6b77af498984cfce65ddf66c8795bb"
  version "0.0.20"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/flow/releases/download/v0.0.20"
    sha256 cellar: :any, x86_64_linux: "8751c990bf5a842de26e848663f205b18a3ddc176ef8cfbb2634f5e0839f7aa2"
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

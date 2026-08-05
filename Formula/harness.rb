class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "14e5fea720abdfb8d752ae0d1f31b137846dab0904f405a1d42a7a676b7618e1"
  version "0.5.0"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.0"
    sha256 cellar: :any, x86_64_linux: "b44e6ec9e57559d33a34ecb65b12e7aefab1bedb0ff6027cf172b09650b0429d"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness", "./cmd/harness"
  end

  test do
    assert_match "harness v#{version}", shell_output("#{bin}/harness --version")
  end
end

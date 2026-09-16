class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.44.tar.gz"
  sha256 "663c57410e3d004aadf4da6dd43a091386a71aabfcda9f0a60ed18b1072db5f4"
  version "0.5.44"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.44"
    sha256 cellar: :any, x86_64_linux: "23a2f26d12527fc4b658c17d1e677c02ecc71b5a4c68d578a01afb506969cdcd"
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

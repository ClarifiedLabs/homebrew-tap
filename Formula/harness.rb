class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.33.tar.gz"
  sha256 "1fca575736ff5a735e684de7b74a5ec34e329af961d0e9c318906df80fd73a0c"
  version "0.0.33"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.33"
    sha256 cellar: :any, x86_64_linux: "b6c71bcb5e37a709f71971f07c897c230f2b50566a342efc67cca990a25b0f27"
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

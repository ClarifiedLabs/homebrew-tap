class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.20.tar.gz"
  sha256 "fa117522ee1924837e63a61565377eef9ffb8955dcbcd79b6a74c1f333aa9807"
  version "0.5.20"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.20"
    sha256 cellar: :any, x86_64_linux: "566dd125b07d4da9a5afb8e9b744dab3d7bf6946f4e8e6ecd3bf26bf55c64e03"
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

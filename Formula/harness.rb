class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7eaca68fd58375f57f40e5e5e38e256a66595acc752f6cfd1b059cff036c876d"
  version "0.3.0"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.3.0"
    sha256 cellar: :any, x86_64_linux: "a18837a9c8354095876eaf92dbd4f947eb5a123dda62a4b4e4305e67c4a62970"
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

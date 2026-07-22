class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "bbd380289d0361e46ec559886b0095f91165f007fa088d1c28349e3f7bf34d61"
  version "0.1.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.1.3"
    sha256 cellar: :any, x86_64_linux: "3b1f681925b0ec07b275c59a0561e1ac7bdbeab5fe133a3938bbe7dc787d463d"
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

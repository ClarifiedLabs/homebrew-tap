class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.9.tar.gz"
  sha256 "92603a0713fa61e597634910cdbdc39c3579c49b0feb691d7b18dd5b92b93a8d"
  version "0.5.9"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.9"
    sha256 cellar: :any, x86_64_linux: "39573f5b1cbefe1e745768bcaa2c3d839a51535ed5eb428d792b94f0f46feb6a"
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

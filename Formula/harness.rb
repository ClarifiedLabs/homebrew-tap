class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.0.25.tar.gz"
  sha256 "b9eea9edf89d89aec8045f16b3ac04951839776c3c28ff29766cba620a08fbd4"
  version "0.0.25"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.0.25"
    sha256 cellar: :any, x86_64_linux: "ee6ac6340ed05681dccdebd884c63b8e1a20be0a84e1198e0f9582423e703980"
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

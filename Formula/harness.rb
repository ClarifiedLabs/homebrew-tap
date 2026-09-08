class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.34.tar.gz"
  sha256 "e5a38eefd207c1c49af430d70df6ba49b342ee3b24efc61b65d322d4adeed7f2"
  version "0.5.34"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.34"
    sha256 cellar: :any, x86_64_linux: "9c6e0de4cbd5a228c49960e5fc5ce443b740848ce870f10d405ceb3ab7bb9235"
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

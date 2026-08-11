class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "e436b2121b39dcc73e56a16bac3ea901a7985fc22ad78f5d952c24282e6dfbd1"
  version "0.5.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.7"
    sha256 cellar: :any, x86_64_linux: "4a226e4756dfe3365dc5c11cc1c07fd8aa68a8d1571e408d01f8bff0052983a8"
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

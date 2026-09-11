class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.42.tar.gz"
  sha256 "67df8ee903997cfe332658c71a4d4de14c6dea258b312295c2f8e46e5a85ced5"
  version "0.5.42"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.42"
    sha256 cellar: :any, x86_64_linux: "eac27d1c45f5bf44f0c41ad616468edf0817a1250cdc5c89d3b5086d7e2e98d7"
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

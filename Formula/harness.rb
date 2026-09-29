class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.55.tar.gz"
  sha256 "77b7f91df16a16af94e45f36ac19bb9ba23447ed428a3a6690cfc4f2013f6d06"
  version "0.5.55"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.55"
    sha256 cellar: :any, x86_64_linux: "21e0850ba6a862e4011224eff29e1a227b3bd6974487f774af4d5989b6ed351a"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
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

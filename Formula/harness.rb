class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.22.tar.gz"
  sha256 "4543c950c78002262a2cade8eec4d71dae0a9b93ada60f1a1e82cda66b7f4523"
  version "0.5.22"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.22"
    sha256 cellar: :any, x86_64_linux: "520c56385404b65b852e3c4ebd0712e64d395e1036cc9146b9f6799ce73dfff5"
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

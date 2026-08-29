class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.25.tar.gz"
  sha256 "65eb2f0ec443ccbd2eb0a6536cfa0fa477fdbbb5d72ea6f72a8396d38b6b9b1e"
  version "0.5.25"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.25"
    sha256 cellar: :any, x86_64_linux: "88f8e02028c2590db34887832e3772156b9c695bcd5bd5551361c44412e722ec"
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

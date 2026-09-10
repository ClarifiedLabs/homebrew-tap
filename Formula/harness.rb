class Harness < Formula
  desc "Tool-using LLM harness CLI"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.39.tar.gz"
  sha256 "62a93c374108eea6df8caa56e13b8ec27e4dc4204ac138b7efdde968044d1e1d"
  version "0.5.39"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.39"
    sha256 cellar: :any, x86_64_linux: "4c4b64c285a797c90cfaa73abe47dcac14a51db5beeb70bffdc898662324a1a9"
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

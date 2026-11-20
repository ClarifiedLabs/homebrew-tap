class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.7.tar.gz"
  sha256 "aed137009a42c27fbb483431894908cdfa7e2e99e6ef8d7731c780d6fd48f3f8"
  version "0.0.7"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cd86a40a5a3b3f9afb42ad54247be3cac175b4536f70b70173e69388c1881c2b"
    sha256 cellar: :any_skip_relocation, tahoe:        "2296b79c28f1987472d0765f1158428ab3cd810b145aeab90f88ef6e6ce185e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "805ce3fe589952e5ee046bbb71d4eab2c4709c992728439c69ac4c82e0aab995"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "891560d95c75057a42085b741b00251e335bb63e69c02b5ec715cf8fde8fb897"
  end

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/ClarifiedLabs/mdcli/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"md", "./cmd/md"
  end

  test do
    assert_match "md v#{version}", shell_output("#{bin}/md --version")
    (testpath/"doc.md").write("# Title\n\nSome **bold** text.\n")
    assert_match "Title", shell_output("#{bin}/md -color never -p never #{testpath}/doc.md")
  end
end

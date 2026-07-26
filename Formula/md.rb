class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.2.tar.gz"
  sha256 "48d8c43fb33f46b6743671cc8145058e251bd0d9c7136d575e7f9d500a390ee0"
  version "0.0.2"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afdeeffedd92896a537ff69d64b26bf6365a9d78b77a0348e5452425b4eaf8c6"
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

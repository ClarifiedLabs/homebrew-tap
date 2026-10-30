class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "e0f31d66ca53301c9ced743fcfb86412dbf8e3a75ceeabf33b6a68b02ca7d978"
  version "0.0.6"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8bfbe394589c5e7ecd985a2f714c35c43c9cf75441e8d8a98989c3eb3768beae"
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

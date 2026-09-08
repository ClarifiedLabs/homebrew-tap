class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.4.tar.gz"
  sha256 "cecae94a666772eddb89aea65dfc692017c32590bcb6810d1506177f2a979394"
  version "0.0.4"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.4"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1944b3fdfad0a3e390221236ad4f8870738a71f87c4766a926ddf957e7071c19"
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

class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.3.tar.gz"
  sha256 "be56c4e6eb9dda19ecffe8d283965ac6b570557127d8ec5be3fd3e91ca5d5105"
  version "0.0.3"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7ab5b81dfbb85e60fdd93cfa99ae74dd4921504d49277f693b345e56b5b696dd"
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

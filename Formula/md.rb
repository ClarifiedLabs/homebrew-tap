class Md < Formula
  desc "Terminal Markdown viewer with ASCII Mermaid diagrams"
  homepage "https://github.com/ClarifiedLabs/mdcli"
  url "https://github.com/ClarifiedLabs/mdcli/archive/refs/tags/v0.0.8.tar.gz"
  sha256 "19630c0b7210f04104ac701ab1f1028cac96eb62f77dc203969dd9f05373ff15"
  version "0.0.8"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/mdcli/releases/download/v0.0.8"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "8020cbfb8e19dbeb1faf5411ba7f0f8048a37e0d65600e0f93f3d53047cdfda1"
    sha256 cellar: :any_skip_relocation, tahoe:        "d2e7ebb92912ce4fe575ab6b3c9d1db5e7a12363d001d006cf97a89d12538e01"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "7987b1650ca306e31d65a84e47fe6bb4e714c4d06e4110682f21efbef141cab8"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f113b8b4d3f11e7f30c725e133660bcb98c4cc1cd506ff64fa758f458d93ebf4"
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

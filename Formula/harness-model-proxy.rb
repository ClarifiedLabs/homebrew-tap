class HarnessModelProxy < Formula
  desc "Provider and model proxy for harness"
  homepage "https://github.com/ClarifiedLabs/harness"
  url "https://github.com/ClarifiedLabs/harness/archive/refs/tags/v0.5.68.tar.gz"
  sha256 "c381994b3e9613bcdab64b5296faaf18df48f8f043561c9499cf98bf90b82e2c"
  version "0.5.68"
  license "MIT"

  bottle do
    root_url "https://github.com/ClarifiedLabs/harness/releases/download/v0.5.68"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "cd67f81085a56341eda9c7aa5f072f629a47a4d4979ec217a5fd8a0e0d8d66e9"
    sha256 cellar: :any_skip_relocation, arm64_linux:  "68f8dba091ec2af5a7217c01feeb4035d83652c58882c2400adfd07f7d614888"
    sha256 cellar: :any,                 x86_64_linux: "cde753e44f129fbcb582afc206d6a52902eafb76ada3924bb502b9f2161bf8a1"
  end

  depends_on "go" => :build

  def install
    ENV["GOWORK"] = "off"
    ldflags = %W[
      -s -w
      -X harness/internal/buildinfo.Version=v#{version}
    ]
    system "go", "build", "-trimpath", "-ldflags", ldflags.join(" "), "-o", bin/"harness-model-proxy", "./cmd/harness-model-proxy"
    doc.install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "harness-model-proxy v#{version}", shell_output("#{bin}/harness-model-proxy --version")
  end
end

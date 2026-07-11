class Cengine < Formula
  desc "Docker Engine-compatible daemon using Apple Containerization"
  homepage "https://github.com/ClarifiedLabs/cengine"
  url "https://github.com/ClarifiedLabs/cengine/releases/download/v0.0.9/cengine-0.0.9.dmg"
  sha256 "152c953e7e2f3236f133202dd477dd24b80d965fd4eba73476824e95f342d3c8"
  version "0.0.9"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos => :tahoe

  conflicts_with cask: "cengine"

  def install
    bin.install "cengine"
  end

  service do
    run [opt_bin/"cengine", "service", "run"]
    keep_alive successful_exit: false
    throttle_interval 60
    process_type :interactive
    log_path var/"log/cengine.log"
    error_log_path var/"log/cengine.log"
    environment_variables PATH: "#{std_service_path_env}:/usr/local/bin"
  end

  test do
    assert_match "cengine #{version}", shell_output("#{bin}/cengine version")
  end
end

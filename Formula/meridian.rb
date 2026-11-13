# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.7.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.2/meridian_0.7.2_macOS_arm64.tar.gz"
      sha256 "91b13641a74e0684bd875d12da5afe1042a300f60c6139672fb5d6b880798fb1"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.2/meridian_0.7.2_macOS_amd64.tar.gz"
      sha256 "881ac5bd0ba9acf20cec45172dabbe35e0dcdf1bb6770bce05414400c443355e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.2/meridian_0.7.2_linux_arm64.tar.gz"
      sha256 "d321a33562ebbc7e3c0d1ce5039dd11e04a600513c7875a7ea37abaaa09ef02c"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.7.2/meridian_0.7.2_linux_amd64.tar.gz"
      sha256 "0d34376d892727cabfcf3757deb1f866bb3bda9afb001ced9432540788e0f528"
    end
  end

  def install
    bin.install "meridian", "meridiand"
  end

  def caveats
    <<~EOS
      meridiand needs a running Docker engine (Docker Desktop, OrbStack, or
      the Docker service). Start it in the background with:
        brew services start meridian
      Then open http://127.0.0.1:8080/ui/
    EOS
  end

  service do
    run [opt_bin/"meridiand", "--provider=docker"]
    keep_alive true
    log_path var/"log/meridiand.log"
    error_log_path var/"log/meridiand.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meridiand --version")
    assert_match version.to_s, shell_output("#{bin}/meridian --version")
  end
end

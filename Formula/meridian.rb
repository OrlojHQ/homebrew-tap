# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.11.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.1/meridian_0.11.1_macOS_arm64.tar.gz"
      sha256 "e72c258ae9ae654437e53f4641740e7c3c96f981e3efae16ec39d0c14d0c9563"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.1/meridian_0.11.1_macOS_amd64.tar.gz"
      sha256 "323609c8cba4364bfb88e136c2a31e4ff750c53f98a2332569f50ca865c7e93e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.1/meridian_0.11.1_linux_arm64.tar.gz"
      sha256 "2314c6393abcbafee4cd678efb15a029678349013aa26c0b61f335be528e7fab"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.1/meridian_0.11.1_linux_amd64.tar.gz"
      sha256 "16674af3e37dead83364e4daf5e2daf1de43538fc53abcb2ea2354706ea885a5"
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

# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.5.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.5.0/meridian_0.5.0_macOS_arm64.tar.gz"
      sha256 "6e555a282a588b5152661c084c97d7a891e2d8b3ad8b6d11ae7a70b6ca49d1d5"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.5.0/meridian_0.5.0_macOS_amd64.tar.gz"
      sha256 "2540aa1913c87e307adccb347c26c8725323aae66102075be69dbd9d401cc27f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.5.0/meridian_0.5.0_linux_arm64.tar.gz"
      sha256 "bf89f6d57c72c39de5428476d2f8adbf99f0a92f83417a32dd5ca646c3660dd5"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.5.0/meridian_0.5.0_linux_amd64.tar.gz"
      sha256 "e3b8b3d7c39322108bd4bbe96832dc2ce66ee20ad98c827b9ad84fc2780cf393"
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

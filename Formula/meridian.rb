# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.4.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.1/meridian_0.4.1_macOS_arm64.tar.gz"
      sha256 "5975bbe1feb641a7b31c2f9a670df6d6e2db4406df145fd3e8370ec84251b85f"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.1/meridian_0.4.1_macOS_amd64.tar.gz"
      sha256 "9d823173da261726a5a2b8bb4c6187e11f9ec00edc7984f5e58405ce270d6f62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.1/meridian_0.4.1_linux_arm64.tar.gz"
      sha256 "c001ee14c7f6a4b9be0e0c7313069c1f790047cf4cd222f3f205741a8e12655b"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.4.1/meridian_0.4.1_linux_amd64.tar.gz"
      sha256 "8f850fa1797d525424e98ee9624f37cc85c381a47916780efdcc29b236b22bf0"
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

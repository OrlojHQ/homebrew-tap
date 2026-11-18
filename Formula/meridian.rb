# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.11.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.5/meridian_0.11.5_macOS_arm64.tar.gz"
      sha256 "72458f2553d2560cb65caa5a3448235a68ab3645d44b1cefd71ed57e76935779"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.5/meridian_0.11.5_macOS_amd64.tar.gz"
      sha256 "29637a5a8ea4bfcc4edfc366fbda0035a62871e29c1f76cccbf8aaa0abbab379"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.5/meridian_0.11.5_linux_arm64.tar.gz"
      sha256 "d5a1998d572082cb580c208becc429da20f511c0634fc6772462601d18e671b2"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.11.5/meridian_0.11.5_linux_amd64.tar.gz"
      sha256 "2630e5e1dbcc54f1fe138e5ea4da6d0754cda5b0bfaf49887a20eee3c72aaf5d"
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
    # A service starts with a short PATH. Include the Homebrew prefix so
    # meridiand can find gh beside other tools installed the same way.
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/sbin:/usr/bin:/bin:/usr/sbin:/sbin"
    keep_alive true
    log_path var/"log/meridiand.log"
    error_log_path var/"log/meridiand.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/meridiand --version")
    assert_match version.to_s, shell_output("#{bin}/meridian --version")
  end
end

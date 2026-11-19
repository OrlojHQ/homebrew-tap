# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.13.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.13.0/meridian_0.13.0_macOS_arm64.tar.gz"
      sha256 "9884fdb35b95a65660191b015181a1c648fe6824c786933882786f3d17d32aa7"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.13.0/meridian_0.13.0_macOS_amd64.tar.gz"
      sha256 "9cb2eb88064decc9c445835f0f9f1374fbe886cc243c4d1c0f736b8c796f1bc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.13.0/meridian_0.13.0_linux_arm64.tar.gz"
      sha256 "645417d97f9a8f8ed1a397ab2606a0f02067c0252ee9ce5632b212792391115f"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.13.0/meridian_0.13.0_linux_amd64.tar.gz"
      sha256 "cbb03775698f3bc11cecdf982afce37c4504562d22c294f73d63e1afddb1f4cf"
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

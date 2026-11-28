# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.20.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.20.0/meridian_0.20.0_macOS_arm64.tar.gz"
      sha256 "7e23f1ee0e8c1fc20ee30d7b95e69b97572eff7a4b35925e26f8cb088ce3623b"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.20.0/meridian_0.20.0_macOS_amd64.tar.gz"
      sha256 "cc30741a673b10e76af5dadbfba32d7abaec7512dbe9022208665b23253fe2b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.20.0/meridian_0.20.0_linux_arm64.tar.gz"
      sha256 "99dce94f0301be0a64b4fe0b01da5d71d19e541c692725602e87f23a3a1f7896"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.20.0/meridian_0.20.0_linux_amd64.tar.gz"
      sha256 "4ae3c2a5a9d76f58debdc298f8bfe861cb14053a58ba88d8d5cd46b79edf12a2"
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

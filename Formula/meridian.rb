# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.18.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.1/meridian_0.18.1_macOS_arm64.tar.gz"
      sha256 "2e1062bc7c7d32a0e5cfc97ad28c4dd7629080c01463fa3e3efba391026834f3"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.1/meridian_0.18.1_macOS_amd64.tar.gz"
      sha256 "527f26c05e818fbee9608b74272c0bc6bfeffeb6316eca5d42d25dafd62d89f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.1/meridian_0.18.1_linux_arm64.tar.gz"
      sha256 "269439c295add14a322a17e3ac20f3c69220f05f86db3daefbffb06daef7164a"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.18.1/meridian_0.18.1_linux_amd64.tar.gz"
      sha256 "a1bed78f397305b361bf111de919bb1dba8931534e721e374918014e9153ce41"
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

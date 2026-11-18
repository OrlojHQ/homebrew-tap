# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.12.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.12.0/meridian_0.12.0_macOS_arm64.tar.gz"
      sha256 "41aebb11b26bc079fe6a601f0991600ccb9f01b89ad6ee0645356c6c4ac44f0d"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.12.0/meridian_0.12.0_macOS_amd64.tar.gz"
      sha256 "75edb625a55407d7e3caa445ea2644a3eb2c7dde4606e81c22ec2d5c3d92a5f5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.12.0/meridian_0.12.0_linux_arm64.tar.gz"
      sha256 "018aa7852854f45fb69e9d04828b252c3426858a6c004b3d85e64a7accdbec6d"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.12.0/meridian_0.12.0_linux_amd64.tar.gz"
      sha256 "831e33d306499cc2e555bf2919ba2165796ad7c8119e8d8313ded4a557d5bebf"
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

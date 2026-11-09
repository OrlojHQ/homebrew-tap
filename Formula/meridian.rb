# typed: false
# frozen_string_literal: true

# Generated from deploy/homebrew/meridian.rb.tmpl in OrlojHQ/meridian by
# scripts/render-homebrew-formula.sh. Do not edit; changes are overwritten on
# the next release.
class Meridian < Formula
  desc "Self-hosted cloud agents in disposable Docker workspaces"
  homepage "https://github.com/OrlojHQ/meridian"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.3.0/meridian_0.3.0_macOS_arm64.tar.gz"
      sha256 "8455b11a6fccb3f8da21acc0c9b3684f0fe80b3e5bd0e97353cc50a91c4b1931"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.3.0/meridian_0.3.0_macOS_amd64.tar.gz"
      sha256 "eaaa9342198e475eca24ec43b27bcc58f8bea5609b9a5b7bcbe0e6e7fc547be2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.3.0/meridian_0.3.0_linux_arm64.tar.gz"
      sha256 "70da190c124838267fc213682ca0f1eca19147cb1a9aee5651380da6ee12193e"
    end
    on_intel do
      url "https://github.com/OrlojHQ/meridian/releases/download/v0.3.0/meridian_0.3.0_linux_amd64.tar.gz"
      sha256 "061d40df9ab6594edb7f64d008ce64f81cdb5db5ec4d78dd8f4a10cefd62d43e"
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

class Ormolu < Formula
  desc "Formatter for Haskell source code"
  homepage "https://github.com/tweag/ormolu"
  url "https://github.com/tweag/ormolu/archive/0.3.1.0.tar.gz"
  sha256 "b0bbf229f1878c39aa58dbb71d8cc4fbc4713252c7acbc0fd9921804fecbd273"
  license "BSD-3-Clause"
  head "https://github.com/tweag/ormolu.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "70cd7434a57c0153d1408a67d8315fe70d6011f9372d9f54d7bedd970cc815f5"
    sha256 cellar: :any_skip_relocation, big_sur:       "db763c64ee0667d536beed9a908ef4d098148bf653e06987304320d9bea7eebe"
    sha256 cellar: :any_skip_relocation, catalina:      "075fc7b2afa03d4db8d517a3951ba2bd1d28859013b57e107728a2bd75ebf9d0"
    sha256 cellar: :any_skip_relocation, mojave:        "d990e97bfb7cb25d3090f47a5c1b8e164b8a8a46cfeb2d79216c17337ef339b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c4c6ac58c58e16768b4b9e319b175408312ef54b79ed472307e41653a1340f04" # linuxbrew-core
  end

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end

  test do
    (testpath/"test.hs").write <<~EOS
      foo =
        f1
        p1
        p2 p3

      foo' =
        f2 p1
        p2
        p3

      foo'' =
        f3 p1 p2
        p3
    EOS
    expected = <<~EOS
      foo =
        f1
          p1
          p2
          p3

      foo' =
        f2
          p1
          p2
          p3

      foo'' =
        f3
          p1
          p2
          p3
    EOS
    assert_equal expected, shell_output("#{bin}/ormolu test.hs")
  end
end

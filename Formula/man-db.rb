class ManDb < Formula
  desc "Implementation of the standard Unix man page system, often used on Linux"
  homepage "https://nongnu.org/man-db/"
  url "https://download.savannah.nongnu.org/releases/man-db/man-db-2.8.5.tar.xz"
  sha256 "b64d52747534f1fe873b2876eb7f01319985309d5d7da319d2bc52ba1e73f6c1"

  depends_on "libpipeline"

  def install
    ENV["CC"] = "#{ENV.cc} -arch x86_64"

    system "./configure", "--prefix=#{prefix}", "--with-systemdtmpfilesdir=no", "--with-systemdsystemunitdir=no", "--disable-cache-owner", "--disable-setuid"
    system "make", "CFLAGS=\"-Wl,-flat_namespace,-undefined,suppress\""
    system "make", "install"
  end

  test do
    ENV["PAGER"] = "cat"
    true_man_page = <<~EOS
      TRUE(1)                                      BSD General Commands Manual                                     TRUE(1)

      NAME
           true -- Return true value.

      SYNOPSIS
           true

      DESCRIPTION
           The true utility always returns with exit code zero.

      SEE ALSO
           csh(1), sh(1), false(1)

      STANDARDS
           The true utility conforms to IEEE Std 1003.2-1992 (``POSIX.2'').

      BSD                                                 June 27, 1991                                                BSD
EOS
    output = shell_output("#{bin}/man true")
    assert_match(true_man_page, output)
  end
end

class ManDb < Formula
  desc "Implementation of the standard Unix man page system, often used on Linux"
  homepage "https://nongnu.org/man-db/"
  url "https://download.savannah.nongnu.org/releases/man-db/man-db-2.8.4.tar.xz"
  sha256 "103c185f9d8269b9ee3b8a4cb27912b3aa393e952731ef96fedc880723472bc3"

  depends_on "libpipeline"

  # First patch explanation:
  # The first two patches are actually the same patch for two different files.
  # Since this utility is intended for Linux systems, it expects to chown the
  # installed files as man:man. But, since we're on OS X, this username/group
  # doesn't exist. Obviously, we don't want to create ad-hoc usernames or groups
  # just to install this one program.
  patch :DATA

  def install
    ENV["CC"] = "#{ENV.cc} -arch x86_64"

    system "./configure", "--prefix=#{prefix}", "--with-systemdtmpfilesdir=''"
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

__END__
diff --git a/src/Makefile.am b/src/Makefile.am
index dd7232e6..cc5c9a0d 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -173,11 +173,6 @@ apropos$(EXEEXT): whatis$(EXEEXT)
 all-am: apropos$(EXEEXT)

 install-exec-hook:
-	if [ "$(man_owner)" ] && [ "$(man_mode)" = 6755 ]; then \
-		chown $(man_owner):$(man_owner) \
-			$(DESTDIR)$(bindir)/$(TRANS_MAN) \
-			$(DESTDIR)$(bindir)/$(TRANS_MANDB); \
-	fi
 	chmod $(man_mode) \
 		$(DESTDIR)$(bindir)/$(TRANS_MAN) \
 		$(DESTDIR)$(bindir)/$(TRANS_MANDB)
diff --git a/src/Makefile.in b/src/Makefile.in
index 5ab90d47..4261d6c8 100644
--- a/src/Makefile.in
+++ b/src/Makefile.in
@@ -2214,11 +2214,6 @@ apropos$(EXEEXT): whatis$(EXEEXT)
 all-am: apropos$(EXEEXT)

 install-exec-hook:
-	if [ "$(man_owner)" ] && [ "$(man_mode)" = 6755 ]; then \
-		chown $(man_owner):$(man_owner) \
-			$(DESTDIR)$(bindir)/$(TRANS_MAN) \
-			$(DESTDIR)$(bindir)/$(TRANS_MANDB); \
-	fi
 	chmod $(man_mode) \
 		$(DESTDIR)$(bindir)/$(TRANS_MAN) \
 		$(DESTDIR)$(bindir)/$(TRANS_MANDB)

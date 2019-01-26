class Libpipeline < Formula
  desc "C library for manipulating pipelines of subprocesses"
  homepage "http://libpipeline.nongnu.org/"
  url "https://download.savannah.nongnu.org/releases/libpipeline/libpipeline-1.5.0.tar.gz"
  sha256 "0d72e12e4f2afff67fd7b9df0a24d7ba42b5a7c9211ac5b3dcccc5cd8b286f2b"

  depends_on "pkg-config"

  def install
    ENV["CC"] = "#{ENV.cc} -arch x86_64"

    system "./configure", "--prefix=#{prefix}", "--disable-cache-owner", "--disable-setuid"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <stdio.h>
      #include <stdint.h>
      #include <pipeline.h>
      int main(void)
      {
        pipeline *p = pipeline_new_command_args("true", NULL);
        int status = pipeline_run(p);
        return status;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lpipeline", "-I#{include}", "-o", "test"
    system "./test"
  end
end

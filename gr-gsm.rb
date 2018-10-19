class GrGsm < Formula
  desc "GNU Radio block for receiving GSM transmissions"
  homepage "https://github.com/ptrkrysik/gr-gsm"
  url "https://github.com/ptrkrysik/gr-gsm/archive/v0.42.2.tar.gz"
  sha256 "6127f87c1d295463c607a27cc2fc560e7a2b8684c1b0be10256db06936769976"
  head "https://github.com/ptrkrysik/gr-gsm.git"

  depends_on "cmake" => :build
  depends_on "cppunit" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "swig" => :build
  depends_on "boost"
  depends_on "gnuradio"
  depends_on "libosmocore"

  def install
    mkdir "build" do
      ENV.append "LDFLAGS", "-Wl,-undefined,dynamic_lookup"
      # Point Python library to existing path or CMake test will fail.
      args = %W[
        -DCMAKE_SHARED_LINKER_FLAGS='-Wl,-undefined,dynamic_lookup'
        -DPYTHON_LIBRARY='#{HOMEBREW_PREFIX}/lib/libgnuradio-runtime.dylib'
      ] + std_cmake_args

      ENV.deparallelize
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end

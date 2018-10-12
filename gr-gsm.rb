class GrGsm < Formula
  desc "GNU Radio block for receiving GSM transmissions"
  homepage "https://github.com/ptrkrysik/gr-gsm"
  url "https://github.com/ptrkrysik/gr-gsm/archive/v0.42.2.tar.gz"
  sha256 "6eb112014f20a93dbd4a447415a9702d4caa0fa87a4836d31d4628bc4056f73e"
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

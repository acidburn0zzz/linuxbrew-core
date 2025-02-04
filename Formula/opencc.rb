class Opencc < Formula
  desc "Simplified-traditional Chinese conversion tool"
  homepage "https://github.com/BYVoid/OpenCC"
  url "https://github.com/BYVoid/OpenCC/archive/ver.1.1.3.tar.gz"
  sha256 "99a9af883b304f11f3b0f6df30d9fb4161f15b848803f9ff9c65a96d59ce877f"
  license "Apache-2.0"

  bottle do
    sha256 arm64_big_sur: "c511e94c8ede779f36276e9149f503e88bf9241ed06c15b5f1b667eb66b6a93d"
    sha256 big_sur:       "f03bc24b794a0be72ffeec4b97ad2a7ef350cfbcce48c27480720bfa2b5ddbbe"
    sha256 catalina:      "71a2e9d6df44f77c60ee8bfb22f355dc7cd073ce58a2e990a7e1a9c54039a9a0"
    sha256 mojave:        "d35684ce9298dca475a9f30318e86f8209aef8df8e06a0a930b3d2d500f7bb2f"
    sha256 x86_64_linux:  "49b5f33bf41cbf3508083231d28df927681f23b85a3f02af4da456de93dd0169" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    mkdir "build" do
      system "cmake", "..", "-DBUILD_DOCUMENTATION:BOOL=OFF", *std_cmake_args, "-DCMAKE_INSTALL_RPATH=#{rpath}"
      system "make"
      system "make", "install"
    end
  end

  test do
    input = "中国鼠标软件打印机"
    output = shell_output("echo #{input} | #{bin}/opencc")
    output = output.force_encoding("UTF-8") if output.respond_to?(:force_encoding)
    assert_match "中國鼠標軟件打印機", output
  end
end

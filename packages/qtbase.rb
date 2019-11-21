require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://github.com/qt/qtbase'
  version '5.13.2'
  source_url 'https://download.qt.io/official_releases/qt/5.13/5.13.2/submodules/qtbase-everywhere-src-5.13.2.tar.xz'
  source_sha256 '26b6b686d66a7ad28eaca349e55e2894e5a735f3831e45f2049e93b1daa92121'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'alsa_plugins'
  depends_on 'cups'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetds'
  depends_on 'gstreamer'
  depends_on 'harfbuzz'
  depends_on 'jasper'
  depends_on 'jsoncpp'
  depends_on 'lcms'
  depends_on 'libevent'
  depends_on 'libinput'
  depends_on 'libmng'
  depends_on 'libproxy'
  depends_on 'libvpx'
  depends_on 'nss'
  depends_on 'pcre2'
  depends_on 'protobuf'
  depends_on 're2c'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}/share/Qt-5",
           "--libdir=#{CREW_LIB_PREFIX}",
           '-verbose',
           '-release',
           '-opensource',
           '-confirm-license',
           '-inotify',
           '-system-pcre',
           '-system-zlib',
           '-system-libpng',
           '-system-libjpeg',
           '-system-freetype'
    system 'make'
  end

  def self.install
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end

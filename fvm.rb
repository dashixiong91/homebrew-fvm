class Fvm < Formula
  desc "Flutter SDK versions Manager"
  homepage "https://github.com/xinfeng-tech/fvm"
  url "https://github.com/xinfeng-tech/fvm/archive/v1.0.8.tar.gz"
  sha256 "a135adbfdf8c137c320f7923c1798bd2ffb31041dbc5041a2afb325072d21da9"
  head "https://github.com/xinfeng-tech/fvm.git"

  bottle :unneeded

  def install
    prefix.install "fvm.sh", "init.sh"
  end

  def caveats; <<~EOS
    You should create FVM's working directory if it doesn't exist:

      mkdir ~/.fvm

    Add the following to #{shell_profile} or your desired shell
    configuration file:

      export FVM_DIR="$HOME/.fvm"
      source "#{opt_prefix}/init.sh"  # This loads fvm

    You can set $FVM_DIR to any location.

    Type `fvm help` for further information.
  EOS
  end

  test do
    output = pipe_output("#{prefix}/init.sh 2>&1")
    assert_no_match /No such file or directory/, output
  end
end

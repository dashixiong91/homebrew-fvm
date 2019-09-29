class Fvm < Formula
  desc "Flutter SDK versions Manager"
  homepage "https://github.com/xinfeng-tech/fvm"
  url "https://github.com/xinfeng-tech/fvm/archive/v1.0.1.tar.gz"
  sha256 "a4f3ce9a309938dafafb256257516cd2c6226711800bcb23a3e3300358aaa463"
  head "https://github.com/xinfeng-tech/fvm.git"

  bottle :unneeded

  def install
    prefix.install "fvm.sh", "fvm-exec"
    prefix.install "init.sh", "fvm-init"
  end

  def caveats; <<~EOS
    You should create FVM's working directory if it doesn't exist:

      mkdir ~/.fvm

    Add the following to #{shell_profile} or your desired shell
    configuration file:

      export FVM_DIR="$HOME/.fvm"
      [ -s "#{opt_prefix}/init.sh" ] && \. "#{opt_prefix}/init.sh"  # This loads fvm

    You can set $FVM_DIR to any location, but leaving it unchanged from
    #{prefix} will destroy any fvm-installed Flutter installations
    upon upgrade/reinstall.

    Type `fvm help` for further information.
  EOS
  end

  test do
    output = pipe_output("#{prefix}/fvm-init 2>&1")
    assert_no_match /No such file or directory/, output
    assert_no_match /fvm: command not found/, output
    assert_match "", output
  end
end

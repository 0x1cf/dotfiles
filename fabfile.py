import os
import fabric
import invoke
import urllib.request


def download(url, name):
    fname, _ = urllib.request.urlretrieve(url, name)
    return fname


@fabric.task
def vscode(_context):
    url = 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
    filename = download(url, "vscode.deb")
    invoke.run(f"sudo apt-get install ./{filename}")


@fabric.task
def chrome(_ignore):
    url = "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    filename = download(url, "chrome.deb")
    invoke.run(f"sudo apt-get install ./{filename}")


def apt_get_install(*pkgs):
    cmd = "sudo apt-get install --yes " + " ".join(pkgs)
    invoke.run(cmd)


def sym_link(src, dst):
    src = os.path.expanduser(src)
    dst = os.path.expanduser(dst)

    src_abs = os.path.abspath(src)
    dst_abs = os.path.abspath(dst)
    invoke.run(f"ln -vsf {src_abs} {dst_abs}")


@fabric.task
def nvim(_):
    apt_get_install("python3-dev", "python3-pip",
                    "python3-setuptools", "neovim")
    invoke.run("pip3 install --user -U neovim")
    invoke.run("mkdir -p ~/.config/nvim")
    sym_link('./nvim/init.vim', '~/.config/nvim/init.vim')
    invoke.run("nvim +PlugClean +PlugUpdate +PlugIn +qall")

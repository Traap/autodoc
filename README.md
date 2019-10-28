**autodoc** assembles dynamic and static documentation that has been written in
LaTeX.  Dynamic documents depend upon output produced by running programs that
emit output to the console, web pages, log files, source codr, or other text
files.

# Prerequisites 
1. [autodoc](https://GitHub.com/Traap/autodoc.git)
1. [docbld](https://GitHub.com/Traap/docbld.git)
1. [MiKTeX](https://miktex.org/download)
1. [tlc-article](https://GitHub.com/Traap/tlc-article.git)


# Installation
Copy the text below and paste into a shell.  The commands will:
1. Change directory to home
1. Clone Traap/autodoc
1. Move to autodoc directory
1. Assemble StarterKit
1. View **_build/Starterkit.pdf**

```bash
$ cd $HOME \
     && git clone https://github.com/Traap/autodoc.git \
            && cd autodoc \
            && docbld
```

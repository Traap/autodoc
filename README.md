**autodoc** assembles dynamic and static documentation that has been written in
LaTeX.  Dynamic documents depend upon output produced by running programs that
emit output to the console, web pages, log files, source codr, or other text
files.

# Prerequisites 
1. [Ruby](https://www.ruby-lang.org/en)
2. [MiKTeX](https://miktex.org/download)
3. [tlc-article](https://bitbucket-vial.intra.fresenius.com/scm/soup/tlc-article.git)
4. [docbld](https://bitbucket-vial.intra.fresenius.com/scm/soup/docbld)

# Installation
Copy the text below and paste into a shell.  The commands will:
1. Change directory to home
2. Clone Traap/autodoc
3. Move to autodoc directory
4. Assemble StarterKit
5. View **_build/Starterkit.pdf**

```bash
$ cd $HOME \
     && git clone https://bitbucket-vial.intra.fresenius.com/scm/soup/autodoc.git \
            && cd autodoc \
            && docbld
```

# Project Management
The **autodoc** repository uses a SCRUM framework adapted to standard GitHub
tooling.  **autodoc** is integrated with Travis-ci.org for continuous
integration and AllanConsulting.slack.com for centralized notification.

Please refer to my [Lightweight Project Management](https://github.com/Traap/lpm)
for the project management strategy I use.

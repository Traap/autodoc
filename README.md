**autodoc** assembles dynamic and static documentation that has been written in
LaTeX.  Dynamic documents depend upon output produced by running programs that
emit output to the console, web pages, log files, source codr, or other text
files.

# Prerequisites 
1. ruby 
2. [tlc-article](https://github.com/Traap/tlc-article)
3. [docbld](https://github.com/Traap/docbld)

# Installation
Copy the text below and paste into a shell.  The commands will:
1. Change directory to home
2. Clone Traap/autodoc
3. Move to autodoc directory
4. Assemble static documents 

```bash
$ cd $HOME \
     && git clone http://github.com/Traap/autodoc.git \
            && cd autodoc \
            && docbld
```

# Project Management
The **autodoc** repository uses a SCRUM framework adapted to standard GitHub
tooling.  **autodoc** is integrated with Travis-ci.org for continuous
integration and AllanConsulting.slack.com for centralized notification.

Please refer to my [Lightweight Project Management](https://github.com/Traap/lpm)
for the project management strategy I use.

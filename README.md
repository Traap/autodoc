# Autodoc

Autodoc is a LaTeX documentation framework for building consistent technical,
verification, validation, review, and project-structure reports. It provides
shared boilerplate, glossary definitions, header/footer defaults, report
templates, and example reports that can be built with `docbld`.

The repository is organized around two main areas:

- `boilerplate/`: reusable LaTeX content, document outlines, standard phrases,
  glossary/acronym data, macros, and header/footer defaults.
- `report/`: concrete example reports and design documents that consume the
  boilerplate.

## Prerequisites

Install these tools before building reports:

- A TeX distribution with LaTeX, `makeglossaries`, and related packages.
- [`tlc-article`](https://github.com/Traap/tlc-article.git), the document class
  used by the reports.
- [`docbld`](https://github.com/Traap/docbld.git), the report build wrapper.
- `rake`, used by `docbld` for task execution.

Autodoc reports expect `AUTODOCPATH` to point at this repository:

```bash
export AUTODOCPATH="$HOME/soup/autodoc"
```

Adjust the path to match your checkout location.

## Build

Run build commands from the `report/` directory:

```bash
cd report
docbld list_files
docbld texx
```

Useful `docbld` tasks:

```text
docbld list_files  # List .texx files that will be compiled
docbld texx        # Compile reports to PDF
docbld docx        # Compile reports to DOCX
docbld clean       # Remove temporary products
docbld clobber     # Remove generated files
docbld deploy      # Build and copy output to _build
```

`docbld texx` keeps LaTeX temporary files next to each report. These files are
useful when debugging build problems, especially `.log`, `.aux`, `.acr`, `.gls`,
`.fls`, and `.fdb_latexmk`.

## Reports

The current build includes these report entry points:

```text
autodoc/autodoc.texx
autodoc/test.texx
code-review/code-review.texx
design-review/design-review.texx
dhf-doc/dhf-doc.texx
glossaries/glossaries.texx
header-footer-design/header-footer-design.texx
project-layout/project-layout.texx
tech-plan/tech-plan.texx
tech-report/tech-report.texx
test-plan/test-plan.texx
test-record/test-record.texx
test-report/test-report.texx
tool-test/tool-test.texx
unit-test/unit-test.texx
ver-test/ver-test.texx
```

The `header-footer-design` report documents how report-local, shared, and
default header/footer files compose. The `project-layout` report documents the
expected project directory layout for automation projects.

## Customization

Project-wide defaults are defined in:

```text
boilerplate/customize/customize.tex
```

Common values include:

- `\autodocCompanyName`
- `\autodocConfidential`
- `\autodocDepartmentName`
- Header/footer status, date, revision, version, and ownership fields
- Project-specific acronyms and glossary terms

Individual reports can override shared settings in their local `data/` folder:

```text
report/<report-name>/data/additional-layout.tex
report/<report-name>/data/header-footer.tex
report/<report-name>/data/version.tex
```

When using glossary entries in a report, enable glossaries in
`data/additional-layout.tex`:

```tex
\newboolean{UseAutodocGlossaries}\setboolean{UseAutodocGlossaries}{true}%
```

Then print them in the report body when needed:

```tex
\printGlossaries%
```

## Adding A Report

Create a new directory under `report/` with this basic shape:

```text
report/my-report/
  my-report.texx
  my-report.tex
  data/
    additional-layout.tex
    header-footer.tex
    version.tex
```

The `.texx` file should input the primary `.tex` file:

```tex
\input{my-report.tex}%
```

The report data files usually hook into shared defaults:

```tex
% data/additional-layout.tex
\newboolean{UseAutodocGlossaries}\setboolean{UseAutodocGlossaries}{true}%
\input{../shared/data/additional-layout.tex}%

% data/header-footer.tex
\input{\autodocDir/boilerplate/data/header-footer.tex}%

% data/version.tex
\input{\autodocDir/boilerplate/data/version.tex}%
```

After adding the report, run:

```bash
cd report
docbld list_files
docbld texx
```

## Debugging LaTeX Builds

Start with the report log:

```bash
rg -n "^!|LaTeX Error|Package .* Error|Emergency stop|Fatal error|Undefined control sequence|Runaway" report -g '*.log'
```

For glossary-related issues, verify that:

- `UseAutodocGlossaries` is enabled before boilerplate is loaded.
- Referenced glossary keys exist in `boilerplate/data/abbreviations.tex`,
  `boilerplate/data/definitions.tex`, or `boilerplate/customize/customize.tex`.
- The report calls `\printGlossaries%` if it uses link-producing `\gls{...}`
  references and should include glossary output.
- `makeglossaries` has run for reports that print acronyms or glossaries.

## License

See [LICENSE](LICENSE).

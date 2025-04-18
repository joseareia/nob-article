% Author Name: José Areia 
% Author Contact: jose.apareia@gmail.com
% Version: 1.0.3 - 18/04/2025
% Public Repository: https://github.com/joseareia/nob-article

% Class Information
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NobArticle}[2024/04/27 NobArticle Class]

% Toogle Classes/Options
\usepackage{etoolbox} % Required for conditional logic
\newtoggle{unnumberedsections} % Create toggle for a class option
\settoggle{unnumberedsections}{false} % Default value for the class option
\DeclareOption{unnumberedsections}{\settoggle{unnumberedsections}{true}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Load Master Class
\LoadClass[letterpaper,10pt,twoside]{article}

% Required Packages
\usepackage{graphicx} % Required for including images
\usepackage{amsmath} % Mathematical expressions
\usepackage{amssymb} % Mathematical symbols
\usepackage[dvipsnames]{xcolor} % Using colors within the document
\usepackage{subcaption} % Two figures side-by-side
\usepackage{blindtext}

% Margins
\usepackage[
	top=2.5cm, % Top margin
	bottom=2.5cm, % Bottom margin
	left=2cm, % Left margin
	right=2cm, % Right margin
	footskip=1cm, % Space from the bottom margin to the baseline of the footer
	headsep=0.75cm, % Space from the top margin to the baseline of the header
	columnsep=20pt, % Space between text columns (in twocolumn mode)
	%showframe % Uncomment to show frames around the margins for debugging
]{geometry}

% Header & Footer
\usepackage{fancyhdr} % Required for customizing headers and footers
\usepackage[bottom, hang]{footmisc} % Force footnotes to the bottom
\pagestyle{fancy} \fancyhf{} % Clear default style
\renewcommand{\headrulewidth}{0pt}
\setlength{\footnotemargin}{6pt} % Footnote space
\fancyhead[RO]{\small\textit{\runninghead}}
\fancyhead[LE]{\small\textit{\runninghead}}
\fancyfoot[RO]{\small\textbf{\thepage}}
\fancyfoot[LO]{\footnotesize\footertext}
\fancyfoot[LE]{\small\textbf{\thepage}}
\fancyfoot[RE]{\footnotesize\footertext}

% Fonts
\usepackage[T1]{fontenc} 
\usepackage[tt=false, type1=true]{libertine}
\usepackage[varqu]{zi4}
\usepackage[libertine]{newtxmath}

% Bibliography
\usepackage[
	backend=biber, % Use the biber backend for compiling the bibliography
	citestyle=authoryear, % In-text citation style
	bibstyle=authoryear, % Bibliography style
	sorting=nyt, % Order references
    natbib=true, % Use natbib compatibility mode
    uniquelist=false % Only show one author, e.g. (Author et al., 2023)
]{biblatex}

\setlength\bibitemsep{1.5\itemsep} % Adjust the space between references
\setlength\bibhang{0pt} % Remove indentation
\renewcommand*{\bibfont}{\scriptsize} % Change references font size
\addbibresource{Bibliography/Bibliography.bib} % Reference document

% Highlight both Author and Year in the citations
\ExecuteBibliographyOptions{maxcitenames=1}
\DeclareFieldFormat{citehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{#1}}
\DeclareFieldFormat{textcitehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{%
    #1%
    \ifbool{cbx:parens}
      {\bibcloseparen\global\boolfalse{cbx:parens}}
      {}}}
\savebibmacro{cite}
\savebibmacro{textcite}
\renewbibmacro*{cite}{%
  \printtext[citehyperref]{%
    \restorebibmacro{cite}%
    \usebibmacro{cite}}}
\renewbibmacro*{textcite}{%
  \ifboolexpr{
    ( not test {\iffieldundef{prenote}} and
      test {\ifnumequal{\value{citecount}}{1}} )
    or
    ( not test {\iffieldundef{postnote}} and
      test {\ifnumequal{\value{citecount}}{\value{citetotal}}} )
  }
    {\DeclareFieldAlias{textcitehyperref}{noformat}}
    {}%
  \printtext[textcitehyperref]{%
    \restorebibmacro{textcite}%
    \usebibmacro{textcite}}}

% Tables
\usepackage{tabularx} % Table length
\usepackage{booktabs} % Table style
\usepackage{multirow} % Multirow
\newcommand{\customtableformatting}{
    \renewcommand{\arraystretch}{1.1}\footnotesize
} % Increase space between rows and smaller font
\AtBeginEnvironment{tabular}{\customtableformatting} % Apply to tabular
\AtBeginEnvironment{tabularx}{\customtableformatting} % Apply to tabularx

% Captions
\usepackage{caption} % Required for customizing captions
\captionsetup{skip=6pt} % Whitespace between figures/tables and the caption
\captionsetup{labelfont={bf,footnotesize}, textfont={footnotesize}}
\captionsetup[table]{skip=2pt,singlelinecheck=off,labelsep=newline}
\captionsetup[figure]{skip=7pt,singlelinecheck=off,labelsep=period}

% Lists
\usepackage{enumitem} % Required for list customization
\setlist{noitemsep} % Customize spacing around and inside lists

% Links
\usepackage[bookmarks]{hyperref} % Required for links

% Custom color for citations and references
\newcommand\shade{85}\colorlet{nobcitecolor}{Aquamarine}

\hypersetup{
	colorlinks=true, % Whether to color the text of links
	urlcolor=black, % Color for \url and \href links
	linkcolor=nobcitecolor!\shade!black, % Color for \nameref links
	citecolor=nobcitecolor!\shade!black, % Color of reference citations
}

% Abstract
\usepackage{abstract} % Allows abstract customization
\renewcommand*\abstractname{\vspace{5pt}\normalsize{Abstract}\hfill\vspace{2pt}}
\renewcommand{\abstractnamefont}{\bfseries\vspace{0.5\baselineskip}}
\renewcommand{\abstracttextfont}{\vspace{-0.5\baselineskip}}

\renewenvironment{abstract}
{\par\rule{\linewidth}{.5pt}\par%
{\bfseries \abstractname:}\par}
{\par\rule{\linewidth}{.5pt}}

% Front Cover
\usepackage{titling} % Required for customizing the title
\setlength{\droptitle}{-4\baselineskip} % Move the title up
\pretitle{\begin{flushleft}\Large\bfseries} % Article title pre-formatting
\posttitle{\end{flushleft}} % Article title post-formatting
\preauthor{\begin{flushleft}\small}
\postauthor{\end{flushleft}}
\predate{\begin{flushleft}\footnotesize}
\postdate{\end{flushleft}}
\setlength{\thanksmarkwidth}{3pt}
\setlength{\thanksmargin}{-3pt}
\patchcmd{\maketitle}{plain}{empty}{}{} % Set the headers and footers empty

% Sections
\usepackage{titlesec} % Required for modifying sections

\iftoggle{unnumberedsections} { % Conditional logic for the unnumbered sections
    \setcounter{secnumdepth}{0} } % Don't number sections at any level
{   \setcounter{secnumdepth}{3} } % Number sections down to subsubsections

\titleformat{\section}[block]{%
    \normalsize\raggedright\bfseries%
}{\thesection}{0.5em}{}[]

\titleformat{\subsection}[block]{%
    \raggedright\bfseries\itshape%
}{\thesubsection}{0.5em}{}[]

\titleformat{\subsubsection}[runin]{%
    \bfseries%
}{\thesubsubsection}{5pt}{}[]

\titlespacing*{\section}{0pt}{1\baselineskip}{3pt}
\titlespacing*{\subsection}{0pt}{1\baselineskip}{3pt}
\titlespacing*{\subsubsection}{0pt}{1\baselineskip}{8pt}

% Custom Commands
\newcommand{\runninghead}[1]{\renewcommand{\runninghead}{\footnotesize #1}}
\newcommand{\footertext}[1]{\renewcommand{\footertext}{\footnotesize #1}}

% Todo notes
\newcommand{\todo}[1]{\textcolor{red}{TODO: #1.}}
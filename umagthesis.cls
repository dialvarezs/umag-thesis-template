% Diego Alvarez S.
% LateX class for theses at the University of Magallanes
% Version 1.0.0
% 2024
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{umagthesis}[2024/02/28 UMAG Thesis Format]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions\relax
\LoadClass{memoir}

% packages
\RequirePackage{fontspec}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage[hypcap=false]{caption}
\RequirePackage{setspace}
\RequirePackage{enumitem}
\RequirePackage{csquotes}
\RequirePackage{multicol}
\RequirePackage{eso-pic}
\RequirePackage{tikz}
\RequirePackage{ifthen}
\RequirePackage[fit]{truncate}

% setup babel
\@ifclasswith{umagthesis}{spanish}{
	\RequirePackage[spanish,es-tabla]{babel}
}{
	\RequirePackage[english]{babel}
}

% margins
\RequirePackage[
	top        = 2.5cm,
	bottom     = 2.5cm,
	outer      = 2.5cm,
	inner      = 3cm,
	headsep    = 0.6cm,
	footskip   = 1cm,
]{geometry}

% linking and pdf options
\RequirePackage[
	final,
	hidelinks,
	pdfusetitle
]{hyperref}

% references
\RequirePackage[
	language=english,
	autolang=other,
	style=nature,
	sorting=none,
	minnames=2,
	doi=true,
	url=false,
	isbn=false
]{biblatex}

% fonts
\RequirePackage{fontspec}

\protrudechars=2
\adjustspacing=2
\newfontfeature{Microtypography}{protrusion=default;expansion=default;}
\directlua{fonts.protrusions.setups.default.factor=.5}

\defaultfontfeatures{RawFeature={+axis={wght=400}}}

\setmainfont[
	Microtypography,
	BoldFont={NotoSans-Bold},
	ItalicFont={NotoSans-Italic},
	BoldItalicFont={NotoSans-BoldItalic},
	Path={./.cls_resources/fonts/Noto_Sans/},
	Extension={.ttf}
]{NotoSans-Regular}

\setmonofont[
	Microtypography,
	BoldFont={NotoSansMono_Condensed-Bold},
	Path={./.cls_resources/fonts/Noto_Sans_Mono/},
	Extension={.ttf}
]{NotoSansMono_Condensed-Regular}

\newfontfamily\headingfont[
	Microtypography,
	BoldFont={Philosopher-Bold},
	ItalicFont={Philosopher-Italic},
	BoldItalicFont={Philosopher-BoldItalic},
	Path={./.cls_resources/fonts/Philosopher/},
	Extension={.ttf}
]{Philosopher-Regular}


% colors
\definecolor{umagBlue}{HTML}{4a5cab}
\definecolor{umagViolet}{HTML}{593d80}
\definecolor{umagVioletLighter}{HTML}{a390ca}
\definecolor{umagVioletLight}{HTML}{dcd2ea}
\definecolor{gray20}{gray}{0.2}
\definecolor{gray50}{gray}{0.5}
\definecolor{gray70}{gray}{0.7}

% definitions
\def\degreedate#1{\gdef\@degreedate{#1}}
\def\degree#1{\gdef\@degree{#1}}
\def\supervisor#1{\gdef\@supervisor{#1}}
\def\cosupervisor#1{\gdef\@cosupervisor{#1}}
\def\department#1{\gdef\@department{#1}}
\def\faculty#1{\gdef\@faculty{#1}}
\def\coverimage#1{\gdef\@coverimage{#1}}
\def\@graduationpurpose{Tesis para optar al grado de}

\newcommand{\graduationpurpose}[1]{%
    \renewcommand{\@graduationpurpose}{#1}%
}

\newcommand{\logo}[1][4cm]{\includegraphics[width=#1]{.cls_resources/img/umag_logo}}

% define flags for front, main and back matter
\newif\if@frontmatter
\newif\if@mainmatter
\newif\if@backmatter

\let\oldfrontmatter\frontmatter
\renewcommand{\frontmatter}{%
	\pagestyle{plain}
	\oldfrontmatter
	\global\@frontmattertrue
	\global\@mainmatterfalse
	\global\@backmatterfalse
	\pagenumbering{roman}
	\setcounter{page}{1}
}

\let\oldmainmatter\mainmatter
\renewcommand{\mainmatter}{%
	\cleardoublepage
	\pagestyle{fancy}
	\oldmainmatter
	\global\@frontmatterfalse
	\global\@mainmattertrue
	\global\@backmatterfalse
	\pagenumbering{arabic}
}

\let\oldbackmatter\backmatter
\renewcommand{\backmatter}{
	\cleardoublepage
	\pagestyle{plain}
	\oldbackmatter
	\global\@frontmatterfalse
	\global\@mainmatterfalse
	\global\@backmattertrue
	\incrementVpos
}

% length for vertical positioning
\newlength{\thumbVpos}
\setlength{\thumbVpos}{5cm}  % initial vertical position

% increment vertical position for each chapter
\newcommand{\incrementVpos}{\addtolength{\thumbVpos}{2.2cm}}

% command to make thumb index
\newcommand{\drawThumb}[2][r]{
	\begin{tikzpicture}[remember picture,overlay]
		\ifthenelse{\equal{#1}{r}}{%
			\node [fill=umagVioletLighter, text=white, minimum width=1cm, minimum height=2cm, anchor=north east]
			at ([xshift=1pt,yshift=-\thumbVpos]current page.north east) {\headingfont\itshape\HUGE#2};
		}{%
			\node [fill=umagVioletLighter, text=white, minimum width=1cm, minimum height=2cm, anchor=north west]
			at ([xshift=-1pt,yshift=-\thumbVpos]current page.north west) {\headingfont\itshape\HUGE#2};
		}
	\end{tikzpicture}
}
% command to place thumb index
\newcommand{\placeThumb}[1][\thechapter]{
	\ifthenelse{\boolean{@twoside}}{
		\checkoddpage
		\ifoddpage
			\drawThumb[r]{#1}
		\else
			\drawThumb[l]{#1}
		\fi
	}{%
		\drawThumb{#1}
	}
}
% command to set thumb index depending on the matter
\def\thumbindex{
	\if@mainmatter
		\placeThumb
	\else
		\if@frontmatter \placeThumb[P] \else \placeThumb[\#] \fi
	\fi
}

% increment vertical position at the end of each chapter (mainmatter only)
\renewcommand{\memendofchapterhook}{
	\if@mainmatter \incrementVpos \fi
}

% page style
\renewcommand{\headrulewidth}{0pt}

\fancypagestyle{fancy}{
	\fancyhf{}
	\ifthenelse{\boolean{@twoside}}{
		\fancyhead[LE]{\small\color{gray50}\truncate{\textwidth}{\nouppercase{\leftmark}}}
		\fancyhead[RO]{\small\color{gray50}\raggedleft{\truncate{\textwidth}{\nouppercase{\rightmark}}}}
	}{%
		\fancyhead[L]{\small\color{gray50}\truncate{0.475\textwidth}{\nouppercase{\leftmark}}}
		\fancyhead[R]{\small\color{gray50}\raggedleft{\truncate{0.475\textwidth}{\nouppercase{\rightmark}}}}
	}
	\fancyfoot[C]{
		\small\color{gray70}\thepage%
		\thumbindex
	}
}

\fancypagestyle{plain}{%
	\fancyhf{}%
	\fancyfoot[C]{%
		\small\color{gray70}\thepage%
		\thumbindex
	}
	\renewcommand{\headrulewidth}{0pt}
}

% cover page
\newcommand{\makecover}{%
	\thispagestyle{empty}
	\AddToShipoutPictureBG*{%
		\AtPageLowerLeft{%
			\hspace*{.25\paperwidth}
			\color{umagViolet}
			\rule{.75\paperwidth}{\paperheight}
		}%
	}%
	\AddToShipoutPictureBG*{%
		\AtPageLowerLeft{%
			\hspace*{.45\paperwidth}%
			\raisebox{1cm}{
				\includegraphics[width=.55\paperwidth]{.cls_resources/img/umag_watermark_violet}
			}
		}%
	}%
	\AddToShipoutPictureBG*{%
		\AtPageUpperLeft{%
			\parbox[t][3cm][b]{5.1cm}{
				\hspace*{0.6cm}
				\logo
			}
		}%
	}%

	\hspace{3.4cm}%
	\parbox[b][0.83\textheight][t]{.75\textwidth}{
		\centering
		\color{white}
		\headingfont
		\large
		\OnehalfSpacing
		\vspace{2cm}
		{\HUGE\bfseries \@title \par}
		\vfill
		\@ifundefined{@coverimage}{}{
			\includegraphics[height=8cm]{\@coverimage}
		}
		\vfill
		{\huge\bfseries \@author \par}
	}
	\clearpage
}

% title page
\renewcommand{\maketitle}{%
	\thispagestyle{empty}
	\AddToShipoutPictureBG*{%
		\AtPageUpperLeft{%
			\parbox[t][6cm][b]{6.1cm}{
				\hspace*{2cm}
				\logo
			}
		}
	}

	\vspace*{1cm}
	\hspace*{3.5cm}
	{\color{umagViolet} \rule{3pt}{0.7\paperheight}}
	\hspace*{.3cm}
	\parbox[b][0.87\textheight][t]{.74\textwidth}{%
		\headingfont
		\large
		\OnehalfSpacing
		\vspace{0.5cm}
		{\color{umagViolet}\raggedright\HUGE\bfseries \@title \par}
		\vspace{1.5cm}
		{\huge\bfseries \@author \par}
		\vfill
		{\bfseries Dirigida por} \par
		\@supervisor \par
		\@ifundefined{@cosupervisor}{}{%
			\vspace{1ex} {\bfseries Co-dirigida por} \par \@cosupervisor \par
		}
		\vspace{1.5cm}
		\@graduationpurpose \par \vspace{1ex}
		{\bfseries \@degree} \par
		\vspace{2cm}
		\@ifundefined{@department}{}{\@department \par}
		\@faculty \par
		Universidad de Magallanes \par \vspace{1ex}
		{\bfseries \@degreedate}
	}
	\clearpage
}

% toc
\maxtocdepth{section}
\renewcommand{\cftchapterfont}{\bfseries\color{umagViolet}}
\renewcommand{\cftchapterpagefont}{\bfseries\color{umagViolet}}

% chapter title style
\renewcommand{\printchaptername}{}
\renewcommand{\chapnumfont}{\raggedleft\headingfont\fontsize{90}{92}\bfseries\color{umagViolet}}
\renewcommand{\chaptitlefont}{\raggedleft\normalfont\headingfont\Huge\color{umagViolet}}
\renewcommand{\afterchapternum}{\par\smallskip}
\setlength{\afterchapskip}{4em}

% section title style
\setsecnumformat{\csname the#1\endcsname\enskip{\color{gray}\textbar}\enskip}
\setsecheadstyle{\Large\bfseries\color{umagViolet}}
\setsubsecheadstyle{\large\color{umagViolet}}
\setsubsubsecheadstyle{\normalsize\color{umagViolet}}

% captions
\captionsetup{
	labelfont = bf,
	labelsep  = period
}

% spacing and other options
\OnehalfSpacing
\captionsetup[table]{font={stretch=1.2}}
\captionsetup[figure]{font={stretch=1.2}}
\setlength{\parskip}{.3\baselineskip}
\setlength{\parindent}{0pt}
\renewcommand*{\bibfont}{\normalfont\footnotesize}
\setlength\bibitemsep{0pt}
\setitemize{
	itemsep=2pt,
	topsep=0.2\baselineskip,
	label=\color{umagViolet}\rule[0.3ex]{0.75ex}{0.75ex}
}

% colored cites
\AtEveryCite{\color{umagViolet}}
% but not full cites
\DeclareCiteCommand{\fullcite}{%
	\usebibmacro{prenote}}{%
	\usedriver
	{\defcounter{maxnames}{99}\color{gray20}}%
	{\thefield{entrytype}}}{
	\multicitedelim }{
	\usebibmacro{postnote}
}
